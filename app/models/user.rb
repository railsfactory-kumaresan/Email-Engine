class User < ActiveRecord::Base
  include ServiceUser
  include CsvUploadStatus
  belongs_to :role
  belongs_to :tenant

  def self.confirmation_instructions(user,request_path,confirmation_token)
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "custom-template"
      template_content = [{"content"=>"SIGNUP", "name"=>"TYPE"}]
      message = { 
          "subject" => "Welcome To Inquirly", 
          "from_name" => "admin",  
          "to" =>[{"email" =>user.email}], 
          "from_email"=> "admin@inquirly.com",
          "important" => true, 
          "merge_vars"=>[{"vars"=>[{"content"=>"SIGNUP", "name"=>"TYPE"},{"content"=>check_request_from(request_path),"name"=>"DOMAIN"},{"content"=> user.first_name,"name"=>"FNAME"},{"content"=>confirmation_token,"name"=>"TOKEN"}],
          "rcpt"=> user.email}],
          "merge_language"=>"mailchimp",
          "text" => "Welcome Text",
          "auto_text"=> true,
          "merge"=>true,
          "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
        }

        result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
         response = { :status => :error, :message => "Error!"}  
        end 
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
    end
  end

  def self.reset_password_instructions(user,request_path,reset_password_token)
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "custom-template"
      template_content = [{"content"=>"reset-pswrd", "name"=>"TYPE"}]
      message = { 
          "subject" => "Inquirly-Reset Password instruction", 
          "from_name" => "admin", 
          "to" =>[{"email" =>user.email,"name" => "aman"}], 
          "from_email"=> "admin@inquirly.com",
          "important" => true,
          "merge_vars"=>[{"vars"=>[{"content"=>"RESETPSWRD", "name"=>"TYPE"},{"content"=>check_request_from(request_path),"name"=>"DOMAIN"},{"content"=> user.first_name,"name"=>"FNAME"},{"content"=> reset_password_token,"name"=>"TOKEN"}],
          "rcpt"=> user.email}],
          "merge_language"=>"mailchimp",  
          "merge"=>true, 
          "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
        }
        result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
         response = { :status => :error, :message => "Error!"}  
        end

    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
    end 
  end  
  
  def self.unblock_instructions(user,request_path,unlock_token)
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "custom-template"
      template_content = [{"content"=>"UNBLOCKINSTRUCTION", "name"=>"TYPE"}]
      message = { 
          "subject" => "Inquirly - Unlock instruction", 
          "from_name" => "admin", 
          "to" =>[{"email" =>user.email,"name" => "aman"}], 
          "from_email"=> "admin@inquirly.com",
          "important" => true,
          "merge_vars"=>[{"vars"=>[{"content"=>"UNBLOCKINSTRUCTION", "name"=>"TYPE"},{"content"=> user.first_name,"name"=>"FNAME"},{"content"=>unlock_token,"name"=>"TOKEN"}],
          "rcpt"=> user.email}], 
          "merge_language"=>"mailchimp",
          "merge"=>true,
          "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
        }
        result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
         response = { :status => :error, :message => "Error!"}  
        end   
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
    end 
  end

  def self.user_deactivation(user,admin_email)
    status = user.is_active
    role_name = user.role.try(:name)
    tenant_name = user.tenant.try(:name)
    admin_email = user.parent_id == 0 ? 'admin@inquirly.com' : User.where(id: user.parent_id).first.email
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "Inquirly-custom-template"
      template_content = [
          { "name"    => 'header',
            "content" => user_activation_or_deactivation(user, admin_email)
          }]
      message ={
        "subject" => "Admin Notification Email",
        "from_name" => "admin",
        "to" =>[{"email" =>user.email}],
        "from_email" => admin_email,
        "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
      }

      result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
         response = { :status => :error, :message => "Error!"}  
        end 

      rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"  
    end  
  end


  def self.corporate_user_confirmation(user,admin_email,password)
    p "here MANDRILL_API_KEY",MANDRILL_API_KEY
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "Inquirly-custom-template"
      template_content = [
          { "name"    => "header",
            "content" => sevice_user_confirmation(user, admin_email, password)
          }]
      message = { 
          "subject" => "Welcome To Inquirly", 
          "from_name" => "admin",  
          "to" =>[{"email" =>user.email}], 
          "from_email"=> "admin@inquirly.com",
          "important" => true, 
          "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
        }

        result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
         response = { :status => :error, :message => "Error!"}  
        end 
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
    end
  end

  def self.csv_upload(user, success_count, error_count, total_record, remaining_count,error_list_path)
    attach_file = File.read(error_list_path)
    size = (attach_file.size).to_f/1000.to_f
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "Inquirly-custom-template"
      template_content = [
        { "name"    => "header",
          "content" => csv_message_block(user, success_count, error_count, total_record, remaining_count,size,error_list_path)
        }]
      if size > 2000
        message = get_message(user)
      elsif error_count > 0 || error_count > 0
        attach_file_encoded = Base64.encode64(attach_file)
        message ={
          "subject" => "Customer Information Upload Process Completed",
          "from_name" => "admin",
          "to" =>[{"email" =>"inquirly.aman@gmail.com"}],
          "from_email"=> "admin@inquirly.com",
          "attachments"=>[{"type"=>"text/csv","content"=>attach_file_encoded,
              "name"=>"customer_infos.csv"}],
          "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }] 
        }
      else
        get_message(user)
      end
      result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
          response = { :status => :error, :message => "Error!"}  
        end
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
    end
  end 


  def self.csv_file_error_mail(user, csv_file_status)
   
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "custom-template"
      template_content = [
        {"name" =>"header",
        "content" => csv_error_message(user,csv_file_status) 
        }]
      message ={
        "subject" => "CSV Upload Unsuccessful",
        "to" =>[{"email" =>user.email}],
        "from_email"=> "no-reply@inquirly.com", 
        "important" => "true",
        "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
      }
      result = mandrill.messages.send_template template_name,template_content, message
        if ((result[0]["status"]) == "sent")
          response = { :status => :ok, :message => "Success!"}  
        else
         response = { :status => :error, :message => "Error!"}
        end 
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"  
    end 

  end

  
  ###### Template part of email ##########

  def self.user_activation_or_deactivation(user,admin_email)
    status = user.is_active
    role_name = user.role.try(:name)
    tenant_name = user.tenant.try(:name)
    admin_email = user.parent_id == 0 ? 'admin@inquirly.com' : User.where(id: user.parent_id).first.email
    if status == true
      %Q{
        <p>Dear #{user.first_name},</p>
        <p>Welcome to Inquirly Product<p>
        <p>Sign In Email: <b>#{user.email}</b> </p>
        <p>Current Status: <b> Active </b></p>
        <p>Role: <b>#{role_name}</b></p>
        <p>Assigned to Tenant: <b>#{tenant_name}</b></p>
        <p>Please contact <b> #{admin_email} </b> if you have problems.</p>
        <p>#{admin_email}</p>
        <p>(for any clarification please contact the Admin)</p>
        Regards,<br>
        Inquirly Admin<br>
      }
    else
      %Q{
        <p>Dear #{user.first_name},</p>
        <p>Your account has been de-activated. You cannot access the application<p>
        <p>Thanks & Regards</p>
        <p>#{admin_email}</p>
        <p>(for any clarification please contact the Admin)</p>
        Inquirly Admin<br>
      }
    end  
  end
  
  private
  
  def  self.check_request_from(request_from)
    case request_from
      when 'local'
        ENV['LOCAL_PATH']
      when 'test'
        ENV['TEST_SERVER_PATH']
      when 'staging'
        ENV['STAGIN_SERVER_PATH']
      when 'live'
        ENV['LIVE_SERVER_PATH']  
    end        
  end
end   

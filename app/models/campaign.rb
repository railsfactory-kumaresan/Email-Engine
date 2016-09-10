class Campaign < ActiveRecord::Base

  def self.campaign_unsuccessful(user,type,campaign)
    
    begin
      mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
      template_name = "Inquirly-custom-template"
      template_content = [{
          "name" => "header",
          "content" => campaign_unsuccessful_message(user,type,campaign)
      }]
      message={
        "subject" => "#{user.email} have reached the maximum limit of #{type.upcase} quota",
        "from_name" =>"admin",
        "to" => [{"email" => user.email}],
        "from_email" => "admin@inquirly.com",
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
  
  def self.campaign_unsuccessful_message(user,type,campaign)
    %Q{
      <p>#{user.email },have reached the maximum limit of #{type} quota.</p>
      <p> Camaign Name: #{campaign.label} <p>
      <p>Campaign Schedule On :#{campaign.schedule_on}</p>
      Regards,<br>
      Inquirly Admin<br>
    }
  end

end

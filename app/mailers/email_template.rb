require 'mandrill'
class EmailSend 
  def confirmation_mail(user)
    p "here user ",user.first_name
    begin
      mandrill = Mandrill::API.new "NhjfykhTtFOrXETluJAW6A"
      template_name = "custom-template"
      template_content = [{"content"=>"example content", "name"=>"fname"}]
      message = { 
          "subject" => "Welcome To Inquirly", 
          "from_name" => user.first_name, 
          "text" => "confirmation message",
          "to" =>[{"email" =>user.email,"name" => "aman"}], 
          "merge_language"=>"mailchimp",
          "from_email"=> "admin@inquirly.com",
          "important" => true, 
          "merge_vars"=>[{"vars"=>[{"content"=> user.first_name, "name"=>"FNAME"}],"rcpt"=>"aman@inquirly.com"}],
          "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
        }
               
        mandrill.messages.send_template template_name, template_content, message 
    rescue Mandrill::Error => e
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
    end 
  end
end  
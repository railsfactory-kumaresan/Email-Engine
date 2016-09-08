class SignupMailer < ApplicationMailer

  def user_signed_up
    data = { html_content_only: true }
    mail(to: "inquirly.aman@gmail.com", subject: "Test", body: "<h1>test</h1>", sparkpost_data: data)
  end

end
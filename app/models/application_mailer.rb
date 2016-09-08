require 'sparkpost_rails'
class ApplicationMailer < ActionMailer::Base
  default from: "amar@inquirly.com"
  layout 'mailer'
end
ActionMailer::Base.smtp_settings = {
    user_name: 'SMTP_Injection',
    password: '4b57fb6f58f59a3940c097cf5fe33c67f4c0dbe4',
    address: 'smtp.sparkpostmail.com',
    port: 587,
    enable_starttls_auto: true,
    format: :html,
    from:'amar@inquirly.com',
    domain:'inquirly.com'
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
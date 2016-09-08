module ServiceUser
  extend ActiveSupport::Concern
  included do
    
    def self.sevice_user_confirmation(user, admin_email, password)
      %Q{
        <p>Dear #{user.first_name},</p>
        <p>Welcome to Inquirly Product. Your credentials are as below <p>
        <p>Signin Name: <b>#{user.email}</b> </p>
        <p>Password: <b>#{password}</b> </p>
        <p>Please contact <b> #{admin_email} </b> if you have problems.</p>
        Regards,<br>
        Inquirly Admin<br>
      }
    end
  end
end


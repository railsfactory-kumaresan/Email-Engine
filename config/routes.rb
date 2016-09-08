Rails.application.routes.draw do
#api v1 specifications 
  namespace :api do 
    namespace :v1 do 
      match "userConfirmation" => "user#confirmation", via: [:post]
      match "userResetPassword" => "user#reset_password" , via: [:post]
      match "userUnblock" => "user#unblock_instruction" , via: [:post]
      match "userDeactivation" =>"user#user_deactivation", via: [:post]
      match "coroprateUserConfiramtion" => "user#corporate_user_confirmation", via:[:post]
      match "campaignUnsuccessful" => "campaign#campaign_unsuccessful", via: [:post]
      match "csvUplaod" =>"user#csv_upload", via: [:post]
      match "csvFileError" => "user#csv_file_error", via: [:post] 
    end 
  end 
end
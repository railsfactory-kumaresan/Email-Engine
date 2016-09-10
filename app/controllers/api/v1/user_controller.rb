class Api::V1::UserController < Api::ApiController
  protect_from_forgery with: :null_session
  before_action :check_user
  
  def confirmation
    render :json => User.confirmation_instructions(@user,params[:request_from],params[:token])
  end

  def reset_password
    render :json => User.reset_password_instructions(@user,params[:request_from],params[:token])
  end 

  def unblock_instruction
    render:json => User.unblock_instructions(@user,params[:request_from],params[:token])
  end

  def csv_upload
    render:json => User.csv_upload(user, params[:success_count],params[:error_count], params[:total_record],params[:remaining_count],params[:error_list_path])
  end

  def csv_file_error
    render:json => User.csv_file_error_mail(@user,params[:csv_file_status])
  end
    
  def user_deactivation
    render:json => User.user_deactivation(@user,params[:admin_email])
  end

  def corporate_user_confirmation
    render:json => User.corporate_user_confirmation(@user,params[:admin_email],params[:password])
  end 
end  
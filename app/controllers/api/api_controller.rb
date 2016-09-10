class Api::ApiController < ApplicationController

  def check_user
    @user = User.where(id:params[:user_id]).first
  end
end  
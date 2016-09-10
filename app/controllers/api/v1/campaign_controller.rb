class Api::V1::CampaignController < Api::ApiController
  protect_from_forgery with: :null_session

  before_action :check_user
  before_action :get_camapign

  def campaign_unsuccessful
    render :json => Campaign.campaign_unsuccessful(@user,params[:type],@campaign)
  end
  
  private 
  
  def get_camapign
    @campaign = Campaign.where(id:params[:campaign_id]).first
  end

end  
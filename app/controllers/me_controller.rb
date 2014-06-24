class MeController < ApplicationController
  include OAuth2Client

  def show
    @user = current_user
    access_token = return_access_token
    @user_info = JSON.parse(access_token.get('/oauth/v1/users/self').body)
    @badges = JSON.parse(access_token.get('oauth/v1/users/self/badges').body)
  end

  def accept
    @id = params[:id]
    @user = current_user
    access_token = return_access_token
    @response = JSON.parse(access_token.put("/oauth/v1/users/self/badges/#{@id}/accept").body)
    redirect_to me_path @user
  end

  def reject
    @id = params[:id]
    @user = current_user
    access_token = return_access_token
    @response = JSON.parse(access_token.put("/oauth/v1/users/self/badges/#{@id}/reject").body)
    redirect_to me_path @user
  end
end
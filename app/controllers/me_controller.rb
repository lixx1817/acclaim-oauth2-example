class MeController < ApplicationController
  include OAuth2Client
  rescue_from OAuth2::Error, with: :sign_out_user

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

  protected

  def sign_out_user
    sign_out
    redirect_to root_path
  end
end
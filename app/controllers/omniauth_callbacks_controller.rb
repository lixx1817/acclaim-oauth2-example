class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    auth = env["omniauth.auth"]
    @user = User.connect_to_linkedin(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in @user
      redirect_to edit_user_registration_path @user
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def acclaim
    auth = request.env["omniauth.auth"]
    @user = User.connect_to_acclaim(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      sign_in @user
      session["token"] = auth.credentials.token
      redirect_to me_path @user
    else
      session["devise.twitter_uid"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end
end
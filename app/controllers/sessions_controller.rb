class SessionsController < ApplicationController

  expose(:providers) { Providers::List.call }

  def create
    if request.env["omniauth.auth"].present?
      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      redirect_to root_url
    else
      flash.now[:error] = "Invalid login credentials."
      render :new
    end
  end

end

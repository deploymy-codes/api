class SessionsController < ApplicationController

  expose(:providers) { Providers::List.call }

  def create
    user = Sessions::Create.call oauth: request.env['omniauth.auth'], user: current_user

    if user.present?
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:error] = "Invalid login credentials."
      render :new
    end
  end

end

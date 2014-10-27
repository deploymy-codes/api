class AccountsController < ApplicationController

  def create
    Accounts::Create.call accounts_params
  end

  private

  def accounts_params
    params.permit :provider, :oauth_token, :first_name, :last_name, :email
  end

end

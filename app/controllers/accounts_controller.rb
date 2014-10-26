class AccountsController < ApplicationController

  def create
    Accounts::Create.call
  end

end

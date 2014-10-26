class UserRepository

  def add_or_update_account_to(user)
    unless account_already_exists?
      @account = @user.accounts.create!(
        :provider      => @provider,
        :uid           => @policy.uid,
        :oauth_token   => @policy.oauth_token,
        :oauth_expires => @policy.oauth_expires,
        :oauth_secret  => @policy.oauth_secret,
        :username      => @policy.username
      )

      @policy.create_callback(@account)
    end
  end

  private

  def account_already_exists?(user)
    user.accounts.exists?(provider: @provider, uid: @policy.uid)
  end

  def login
    @account = Account.where(@auth.slice("provider", "uid")).first
    if @account.present?
      refresh_tokens
      @user = @account.user
      @policy.refresh_callback(@account)
    else
      false
    end
  end

  def refresh_tokens
    @account.update_attributes(
      :oauth_token   => @policy.oauth_token,
      :oauth_expires => @policy.oauth_expires,
      :oauth_secret  => @policy.oauth_secret
    )
  end


  def create_new_user
    User.create!(
      :first_name => @policy.first_name,
      :last_name  => @policy.last_name,
      :email      => @policy.email,
    )
  end
end

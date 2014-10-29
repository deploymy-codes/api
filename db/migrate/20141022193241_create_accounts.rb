class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.string :provider
      t.string :oauth_token

      t.timestamps
    end
  end
end

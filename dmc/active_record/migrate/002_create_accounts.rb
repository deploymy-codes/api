class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :oauth_token
      t.string :provide
      t.references :user
      t.timestamps
    end
  end
end

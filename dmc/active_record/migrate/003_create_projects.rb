class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :remote_name
      t.string :url
      t.references :user
      t.timestamps
    end
  end
end

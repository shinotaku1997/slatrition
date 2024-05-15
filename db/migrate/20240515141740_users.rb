class Users < ActiveRecord::Migration[7.1]
  def change
    drop_table :users
  end
end

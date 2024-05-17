class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :body, null: false, foreign_key: true
      t.integer :goal_weight
      t.integer :volume_of_activity

      t.timestamps
    end
  end
end

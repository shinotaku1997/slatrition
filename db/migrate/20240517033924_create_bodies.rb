class CreateBodies < ActiveRecord::Migration[7.1]
  def change
    create_table :bodies do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :sex
      t.integer :age
      t.integer :weight
      t.integer :height

      t.timestamps
    end
  end
end

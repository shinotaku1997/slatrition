class AddColumnToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :calories, :integer
    add_column :recipes, :proteins, :integer
    add_column :recipes, :carbhydarates, :integer
    add_column :recipes, :fats, :integer
    add_column :recipes, :salts, :integer
    add_column :recipes, :fibers, :integer
  end
end

class AddItemsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :title, :string
    add_column :recipes, :ingredients, :text
  end
end

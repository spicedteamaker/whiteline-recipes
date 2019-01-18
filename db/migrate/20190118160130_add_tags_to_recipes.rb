class AddTagsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :tags, :string, array: true
  end
end

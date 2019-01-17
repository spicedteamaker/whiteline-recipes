class AddRecipeRefToInstructions < ActiveRecord::Migration[5.2]
  def change
    add_reference :instructions, :recipe, foreign_key: true
  end
end

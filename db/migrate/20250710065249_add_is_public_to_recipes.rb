class AddIsPublicToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :is_public, :boolean
  end
end

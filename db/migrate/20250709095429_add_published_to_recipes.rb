class AddPublishedToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :published, :boolean, default: false
  end
end

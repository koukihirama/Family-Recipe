class RemoveUserIdFromRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :recipes, :users
    remove_column :recipes, :user_id, :bigint
  end
end
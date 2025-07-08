class AddMemberToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_reference :recipes, :member, foreign_key: true
  end
end

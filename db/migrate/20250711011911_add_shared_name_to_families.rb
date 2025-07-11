class AddSharedNameToFamilies < ActiveRecord::Migration[7.2]
  def change
    add_column :families, :shared_name, :string
  end
end

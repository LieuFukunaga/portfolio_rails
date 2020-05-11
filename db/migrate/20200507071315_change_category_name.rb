class ChangeCategoryName < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :category_name, :string, null: false, unique: true
  end
end

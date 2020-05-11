class AddIndexToCategoryName < ActiveRecord::Migration[5.2]
  def change
    add_index :categories, :category_name
  end
end

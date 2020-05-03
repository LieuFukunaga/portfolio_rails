class AddIndexToListCategories < ActiveRecord::Migration[5.2]
  def change
    add_index :list_categories, [:list_id,:category_id],unique: true
  end
end

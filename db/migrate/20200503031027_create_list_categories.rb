class CreateListCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :list_categories do |t|
      t.references :list, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :lists_categories, :list_id
    add_index :lists_categories, :category_id
    add_index :lists_categories, [:list_id,:category_id],unique: true
  end
end

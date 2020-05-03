class CreateListCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :list_categories do |t|
      t.references :list, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

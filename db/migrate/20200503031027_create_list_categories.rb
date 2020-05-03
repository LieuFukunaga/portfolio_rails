class CreateListCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :list_categories do |t|

      t.timestamps
    end
  end
end

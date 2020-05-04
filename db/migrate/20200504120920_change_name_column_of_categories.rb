class ChangeNameColumnOfCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories ,:name, :string, null: false, unique: true
  end
end

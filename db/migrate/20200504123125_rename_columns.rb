class RenameColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :name, :category_name
    rename_column :lists, :name, :list_name
  end
end

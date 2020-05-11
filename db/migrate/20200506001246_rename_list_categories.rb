class RenameListCategories < ActiveRecord::Migration[5.2]
  def change
    rename_table :list_categories, :goal_categories
  end
end

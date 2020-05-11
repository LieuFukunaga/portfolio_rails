class RemoveReferencesFromListCategories < ActiveRecord::Migration[5.2]
  def change
    remove_reference :list_categories, :list
  end
end

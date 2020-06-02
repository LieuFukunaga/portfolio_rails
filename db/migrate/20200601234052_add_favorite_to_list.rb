class AddFavoriteToList < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :favorite, :integer, limit: 1, default: 0
  end
end

class AddIndexToList < ActiveRecord::Migration[5.2]
  def change
    add_index :lists, :name
  end
end

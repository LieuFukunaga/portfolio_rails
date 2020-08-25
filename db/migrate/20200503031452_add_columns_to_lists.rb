class AddColumnsToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :name, :string, null: false
    add_reference :lists, :user, foreign_key: true
  end
end
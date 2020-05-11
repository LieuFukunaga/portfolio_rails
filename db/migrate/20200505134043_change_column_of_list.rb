class ChangeColumnOfList < ActiveRecord::Migration[5.2]
  def change
    change_column :lists, :list_name, :string, null: false, unique: true
  end
end

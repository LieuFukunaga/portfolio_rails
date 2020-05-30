class AddColumnsToAction < ActiveRecord::Migration[5.2]
  def change
    add_column :actions, :title, :string, null: false
    add_column :actions, :status, :integer, limit: 1, default: 0
    add_reference :actions, :goal, foreign_key: true
    add_reference :actions, :list, foreign_key: true
    add_reference :actions, :user, foreign_key: true
  end
end

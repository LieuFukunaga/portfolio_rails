class AddColumnsToStep < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :title, :string, null: false
    add_column :steps, :status, :integer, limit: 1, default: 0
    add_reference :steps, :goal, foreign_key: true
    add_reference :steps, :user, foreign_key: true
  end
end

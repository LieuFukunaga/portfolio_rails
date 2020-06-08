class ChangeActionToPractice < ActiveRecord::Migration[5.2]
  def change
    rename_table :actions, :practices
  end
end

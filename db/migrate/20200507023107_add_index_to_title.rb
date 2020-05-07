class AddIndexToTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :goals, :title
  end
end

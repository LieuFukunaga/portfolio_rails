class RemoveDefaultFromStepsAndActions < ActiveRecord::Migration[5.2]
  def change
    change_column :steps, :title, :string, null: false
    change_column :actions, :title, :string, null: false
  end
end

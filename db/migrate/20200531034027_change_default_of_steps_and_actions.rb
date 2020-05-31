class ChangeDefaultOfStepsAndActions < ActiveRecord::Migration[5.2]
  def change
    change_column :steps, :title, :string, defalut: "steps"
    change_column :actions, :title, :string, defalut: "actions"
  end
end

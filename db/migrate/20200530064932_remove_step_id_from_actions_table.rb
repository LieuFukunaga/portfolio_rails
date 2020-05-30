class RemoveStepIdFromActionsTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :actions, :step, index: true, foreign_key: true
  end
end

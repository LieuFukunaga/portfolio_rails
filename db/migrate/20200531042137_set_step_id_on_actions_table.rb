class SetStepIdOnActionsTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :actions, :step, foreign_key: true
  end
end

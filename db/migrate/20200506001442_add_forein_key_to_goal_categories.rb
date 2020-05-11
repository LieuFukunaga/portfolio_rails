class AddForeinKeyToGoalCategories < ActiveRecord::Migration[5.2]
  def change
    add_reference :goal_categories, :goal, foreign_key: true
  end
end

class GoalCategory < ApplicationRecord
  belongs_to :goal
  belongs_to :category

  validates :goal_id,presence:true
  validates :category_id,presence:true
end
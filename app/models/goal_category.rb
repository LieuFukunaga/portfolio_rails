class GoalCategory < ApplicationRecord
  belongs_to :goal, optional: true
  belongs_to :category, optional: true
end

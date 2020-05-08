class Category < ApplicationRecord
  has_many :goal_categories, dependent: :destroy
  has_many :goals, through: :goal_categories

  accepts_nested_attributes_for :goal_categories, allow_destroy: true
  accepts_nested_attributes_for :goals

  validates :category_name, null: false, presence:true, uniqueness: true
end

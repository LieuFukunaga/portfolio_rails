class Category < ApplicationRecord
  has_many :goal_categories, dependent: :destroy
  has_many :goals, through: :goal_categories

  validates :category_name, presence:true
  validates :category_name, null: false, null: false

  accepts_nested_attributes_for :goals

end

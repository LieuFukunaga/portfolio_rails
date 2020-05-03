class List < ApplicationRecord
  belongs_to :user

  has_many :categories, through: :list_categories
  has_many :list_categories, dependent: :destroy

  has_one_attached :image

end

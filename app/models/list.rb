class List < ApplicationRecord
  belongs_to :user
  validates :user_id, null: false

  has_many :list_categories, dependent: :destroy
  has_many :categories, through: :list_categories

  has_one_attached :image


end

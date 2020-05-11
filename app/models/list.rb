class List < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy

  validates :user_id, null: false
  validates :list_name, null: false, presence: true


  # has_one_attached :image

end

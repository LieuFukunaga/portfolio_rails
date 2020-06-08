class Practice < ApplicationRecord
  belongs_to :user
  belongs_to :list
  belongs_to :goal
  belongs_to :step

  has_one_attached :practice_image

  # validates :title, format: {with:/\A[^[:blank:]\s、,]+\z/}
  validates :title, length: { minimum: 0, maximum: 20 }
  validates :title, null: false, presence: true

  enum status: {
    doing: 0,
    done: 1,
  }
end

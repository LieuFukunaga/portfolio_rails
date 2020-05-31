class Step < ApplicationRecord
  belongs_to :user
  belongs_to :list
  belongs_to :goal

  has_many :actions, dependent: :destroy

  has_one_attached :step_image

  # validates :title, format: {with:/\A[^[:blank:]\s、,]+\z/}
  validates :title, length: { minimum: 0, maximum: 45 }
  validates :title, null: false, presence: true

  enum status: {
    doing: 0,
    done: 1,
  }
end

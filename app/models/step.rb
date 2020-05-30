class Step < ApplicationRecord
  belongs_to :user
  belongs_to :list
  belongs_to :goal

  validates :title, format: {with:/\A[^[:blank:]\s、,]+\z/}
  validates :title, length: { minimum: 0, maximum: 45 }
  validates :title, null: false, presence: true

  has_many :actions

  has_one_attached :image

  enum status: {
    doing: 0,
    done: 1,
  }
end

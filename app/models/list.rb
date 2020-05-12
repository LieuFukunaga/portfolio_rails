class List < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy

  validates :user_id, null: false
  validates :list_name, null: false, presence: true

  def self.search(search)
    if search
      List.where("list_name LIKE(?)", "%#{search}%")
    else
      List.includes(:user)
    end
  end

end

class List < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy

  validates :user_id, null: false
  validates :list_name, null: false, presence: true

  def self.list_search(search)
    if search
      List.where("list_name LIKE(?)", "%#{search}%")
    end
  end

  def self.task_search(goals, search)
    if search
      goals.where("title LIKE(?)", "%#{search}%")
    end
  end

end

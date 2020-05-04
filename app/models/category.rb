class Category < ApplicationRecord
  validates :name, presence:true,length:{maximum:20}
  validates :name, uniquness: true

  has_many :list_categories, dependent: :destroy
  has_many :list, through: :list_categories
end

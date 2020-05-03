class Category < ApplicationRecord
  validates :name,presence:true,length:{maximum:20}
  has_many :list, through: :list_categories
  has_many :list_categories, dependent: :destroy
end

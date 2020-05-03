class ListCategory < ApplicationRecord
  belongs_to :list
  belongs_to :category
  validates :list_id,presence:true
  validates :category_id,presence:true
end

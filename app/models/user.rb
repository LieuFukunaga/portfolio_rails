class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 255 }

  validates :tel_num, presence: true
  validates :tel_num, uniqueness: true
  validates :tel_num, numericality: true, format: {with: /0[1-9]\d{8,9}/}

  has_one :address, dependent: :destroy
end

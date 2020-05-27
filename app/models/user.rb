class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :goals, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :name, length: { minimum: 1, maximum: 255 }

  validates :email, format: {with: /\A\w+@\w+\.\w+\z/}

  validates :tel_num, presence: true
  validates :tel_num, uniqueness: true
  validates :tel_num, numericality: true, format: {with: /0[1-9]\d{8,9}/}

end

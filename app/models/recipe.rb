class Recipe < ApplicationRecord
  belongs_to :user
  has_many :instructions, dependent: :destroy
  validates :title, presence: true
  validates :ingredients, presence: true
  has_one_attached :picture
end

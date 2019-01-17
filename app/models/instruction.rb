class Instruction < ApplicationRecord
  belongs_to :recipe
  validates :body, presence: true
  has_one_attached :picture
end

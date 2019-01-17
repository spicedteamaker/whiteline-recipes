class Recipe < ApplicationRecord
  belongs_to :user
  has_many :instructions, dependent: :destroy
end

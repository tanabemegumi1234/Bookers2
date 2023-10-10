class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates :title, presence: true
  validates :body, uniqueness: true,length: { minimum: 1, maximum: 200 }
end

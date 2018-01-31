class Rating < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :score, presence: true
  validates :score, numericality: { only_integer: true, greater_than: 0, less_than: 5 }
end

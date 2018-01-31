class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
  validates :title, length: { in: 3..40 }, presence: true
  validates :text, length: { in: 3..500 }, presence: true

  def average_rating
    ratings.average(:score)
  end

  def self.by_average_score(score)
    joins(:ratings).group('posts.id').having("avg(score) = ?", score) 
  end
end

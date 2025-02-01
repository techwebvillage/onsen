class Onsen < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :images
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 1000 }
  validates :rating, inclusion: { in: 1..5 }
  validates :price, presence: true, 
                   numericality: { 
                     greater_than_or_equal_to: 0,
                     less_than: 100000 
                   }
  validates :images, content_type: [:png, :jpg, :jpeg],
                    size: { less_than: 5.megabytes }
                    
  scope :recent, -> { order(created_at: :desc) }
  scope :high_rated, -> { where('rating >= ?', 4) }
  
  def average_rating
    reviews.average(:rating)
  end
end

class Review < ActiveRecord::Base

  validates :rating, presence: true
  
  belongs_to :product
  belongs_to :user

end

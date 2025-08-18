class Achievement < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :date, presence: true
  validates :category, presence: true
end

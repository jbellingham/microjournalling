class User < ApplicationRecord
  has_secure_password
  
  has_many :achievements, dependent: :destroy
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  before_save { self.email = email.downcase }
end

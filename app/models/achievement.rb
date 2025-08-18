class Achievement < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :date, presence: true
  validates :category, presence: true
  
  BRAG_DOC_CATEGORIES = [
    'Projects',
    'Collaboration & mentorship',
    'Design & documentation',
    'Company building',
    'What you learned',
    'Outside of work',
    'Wins or highlights'
  ].freeze
  
  def self.brag_doc_category_options
    BRAG_DOC_CATEGORIES.map { |category| [category, category] }
  end
end

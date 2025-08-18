class Achievement < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :date, presence: true
  validates :category, presence: true
  
  # Unified category system optimized for promotion materials
  CATEGORIES = {
    'Projects' => {
      name: 'Projects',
      description: 'Major projects, features, and technical initiatives you led or contributed to'
    },
    'Leadership & Innovation' => {
      name: 'Leadership & Innovation',
      description: 'Leading teams, creative solutions, and driving organizational change'
    },
    'Collaboration & mentorship' => {
      name: 'Collaboration & Mentorship',
      description: 'Helping others, mentoring, knowledge sharing, and teamwork'
    },
    'Design & documentation' => {
      name: 'Design & Documentation',
      description: 'System design, technical documentation, and architectural decisions'
    },
    'Problem Solving & Recognition' => {
      name: 'Problem Solving & Recognition',
      description: 'Debugging, incident response, awards, and external recognition of your work'
    },
    'Company building' => {
      name: 'Company Building',
      description: 'Process improvements, interviewing, recruiting, and organizational contributions'
    },
    'Learning & Development' => {
      name: 'Learning & Development',
      description: 'New skills, technologies, methodologies, and professional growth'
    },
    'Outside of work' => {
      name: 'Outside of Work',
      description: 'Open source, speaking, writing, and external professional activities'
    }
  }.freeze
  
  def self.category_options
    CATEGORIES.map { |key, info| [info[:name], key] }
  end
  
  def self.brag_doc_categories
    CATEGORIES.keys
  end
  
  def category_info
    CATEGORIES[self.category]
  end
  
  def is_brag_doc_category?
    true  # All categories now get brag doc treatment
  end
  
  def display_category
    category_info&.dig(:name) || category
  end
  
  def category_description
    category_info&.dig(:description) || ''
  end
  
  scope :favorites, -> { where(favorite: true) }
  scope :current_year, -> { where(date: Date.current.beginning_of_year..Date.current.end_of_year) }
  scope :favorite_current_year, -> { favorites.current_year }
end

class BragDocController < ApplicationController
  def export
    @all_achievements = current_user.achievements.order(date: :desc)
    
    # Show only favorites from current year for brag doc export
    @achievements = current_user.achievements.favorite_current_year.order(date: :desc)
    @achievements_by_brag_category = @achievements.group_by(&:category)
    
    # Stats for the export header
    @total_achievements = @all_achievements.count
    @total_favorites = @all_achievements.favorites.count
    @current_year_count = @all_achievements.current_year.count
    
    respond_to do |format|
      format.html
      format.text { render plain: generate_brag_doc_text }
    end
  end

  private

  def generate_brag_doc_text
    doc = []
    doc << "# My Brag Document"
    doc << ""
    doc << "Generated on #{Date.current.strftime('%B %d, %Y')}"
    doc << ""
    
    # Goals section
    doc << "## Goals for this year:"
    doc << ""
    doc << "- [Add your major goals here!]"
    doc << ""
    
    # Process each brag doc category
    Achievement.brag_doc_categories.each do |category|
      achievements_in_category = @achievements_by_brag_category[category] || []
      next if achievements_in_category.empty?
      
      doc << "## #{Achievement::CATEGORIES[category][:name]}"
      doc << ""
      
      achievements_in_category.each do |achievement|
        doc << "### #{achievement.title}"
        doc << "**Date:** #{achievement.date.strftime('%B %d, %Y')}"
        doc << ""
        doc << achievement.description if achievement.description.present?
        doc << ""
        
        if achievement.impact_metrics.present?
          doc << "**Impact & Results:**"
          doc << achievement.impact_metrics
          doc << ""
        end
        
        if achievement.collaboration_details.present?
          doc << "**Collaboration:**"
          doc << achievement.collaboration_details
          doc << ""
        end
        
        if achievement.learning_outcomes.present?
          doc << "**Learning Outcomes:**"
          doc << achievement.learning_outcomes
          doc << ""
        end
        
        if achievement.goals_supported.present?
          doc << "**Goals Supported:**"
          doc << achievement.goals_supported
          doc << ""
        end
        
        doc << "---"
        doc << ""
      end
    end
    
    doc.join("\n")
  end
end

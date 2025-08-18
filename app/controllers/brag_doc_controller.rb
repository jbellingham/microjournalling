class BragDocController < ApplicationController
  def export
    @all_achievements = current_user.achievements.order(date: :desc)
    
    # Show current year favorites as shortlist for selection
    @shortlist_achievements = current_user.achievements.favorite_current_year.order(date: :desc)
    
    # Show only selected achievements in final export
    @export_achievements = current_user.achievements.brag_doc_shortlist.order(date: :desc)
    @achievements_by_brag_category = @export_achievements.group_by(&:category)
    
    # Stats for the export header
    @total_achievements = @all_achievements.count
    @total_favorites = @all_achievements.favorites.count
    @current_year_count = @all_achievements.current_year.count
    @shortlist_count = @shortlist_achievements.count
    @export_count = @export_achievements.count
    
    respond_to do |format|
      format.html
      format.text { render plain: generate_brag_doc_text }
    end
  end
  
  def update_selections
    # Get the list of achievement IDs that should be included
    included_ids = params[:achievement_ids] || []
    
    # First, set all current year favorites to not included
    current_user.achievements.favorite_current_year.update_all(include_in_brag_doc: false)
    
    # Then, set the selected ones to included
    if included_ids.any?
      current_user.achievements.where(id: included_ids).update_all(include_in_brag_doc: true)
    end
    
    redirect_to brag_doc_export_path, notice: 'Brag doc selections updated successfully!'
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
      achievements_in_category = @export_achievements.select { |a| a.category == category }
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

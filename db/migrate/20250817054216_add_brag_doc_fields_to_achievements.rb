class AddBragDocFieldsToAchievements < ActiveRecord::Migration[8.0]
  def change
    add_column :achievements, :brag_doc_category, :string
    add_column :achievements, :impact_metrics, :text
    add_column :achievements, :collaboration_details, :text
    add_column :achievements, :learning_outcomes, :text
    add_column :achievements, :goals_supported, :text
  end
end

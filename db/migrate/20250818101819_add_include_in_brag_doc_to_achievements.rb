class AddIncludeInBragDocToAchievements < ActiveRecord::Migration[8.0]
  def change
    add_column :achievements, :include_in_brag_doc, :boolean, default: false, null: false
  end
end

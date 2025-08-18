class RemoveBragDocCategoryFromAchievements < ActiveRecord::Migration[8.0]
  def change
    remove_column :achievements, :brag_doc_category, :string
  end
end

class AddFavoriteToAchievements < ActiveRecord::Migration[8.0]
  def change
    add_column :achievements, :favorite, :boolean, default: false, null: false
  end
end

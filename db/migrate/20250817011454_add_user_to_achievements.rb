class AddUserToAchievements < ActiveRecord::Migration[8.0]
  def up
    # Add user_id column as nullable first
    add_reference :achievements, :user, null: true, foreign_key: true
    
    # Create a default user for existing achievements
    default_user = User.create!(
      name: "Default User",
      email: "user@example.com",
      password: "password123"
    )
    
    # Assign all existing achievements to the default user
    Achievement.update_all(user_id: default_user.id)
    
    # Now make the column non-nullable
    change_column_null :achievements, :user_id, false
  end
  
  def down
    remove_reference :achievements, :user, foreign_key: true
  end
end

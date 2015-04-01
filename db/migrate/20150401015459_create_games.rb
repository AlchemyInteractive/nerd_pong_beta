class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.integer :winner_id
      t.integer :user1_score
      t.integer :user2_score
    
      t.timestamps
    end
  end
end

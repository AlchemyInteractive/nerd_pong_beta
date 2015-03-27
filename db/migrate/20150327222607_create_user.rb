class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :wins
      t.integer :losses
      t.integer :games_played

      t.timestamps
    end
  end
end

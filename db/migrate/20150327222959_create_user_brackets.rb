class CreateUserBrackets < ActiveRecord::Migration
  def change
    create_table :user_brackets do |t|
      t.integer :user_id
      t.integer :bracket_id
    end
  end
end

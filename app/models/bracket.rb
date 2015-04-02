class Bracket < ActiveRecord::Base
  serialize :bracket, Hash  
  serialize :queue, Array

  belongs_to :user_brackets
  has_many :users, through: :user_brackets
  
  def randomize
    queue.shuffle!.each do |user|
      user.hide_columns
      spot = 0 
      while true
        if bracket[1][spot].count < 2 
          bracket[1][spot].push(user)
          break
        else
          spot += 1
        end
      end
    end
    self.save
  end
end

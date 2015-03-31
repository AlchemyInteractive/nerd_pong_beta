class Bracket < ActiveRecord::Base
  serialize :bracket, Hash  

  belongs_to :user_brackets
  has_many :users, through: :user_brackets
end

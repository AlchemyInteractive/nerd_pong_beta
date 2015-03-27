class Bracket < ActiveRecord::Base
  belongs_to :user_brackets
  has_many :users, through: :user_brackets
end

class User < ActiveRecord::Base
  belongs_to :user_brackets
  has_many :brackets, through: :user_brackets
end

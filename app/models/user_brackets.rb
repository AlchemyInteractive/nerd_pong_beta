class UserBrackets < ActiveRecord::Base
  belongs_to :user
  belongs_to :bracket
end

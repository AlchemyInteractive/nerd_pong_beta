class User < ActiveRecord::Base
  belongs_to :user_brackets
  has_many :brackets, through: :user_brackets
  
  def hide_columns
    [:token, :secret].each do |c|
      send("#{c}=", nil)
    end
    self
  end
  
  def game_wins
    self.wins ? self.wins : 0
  end
  
  def game_losses
    self.losses ? self.losses : 0
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
    user.update(
      name: auth_hash[:info][:name],
      profile_image: auth_hash[:info][:image],
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
      )
    user
  end

end

class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    session[:user_id] = @user.id
    redirect_to edit_user_path(@user.id) 
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
end

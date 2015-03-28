class UsersController < ApplicationController

  def index
  end

  def front_page
    if session[:access_token] && !Bracket.all.select{|i| i.open}.empty?
      redirect_to brackets_path
      return
    end
    render :front
  end

  def authenticate

  end
  
  def oauth_callback
    render 'update_user'
  end
  
  def update_user

  end
end

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
  
  def oauth_callback
    binding.pry
    redirect_to brackets_path
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user].permit(:name))
     redirect_to brackets_path
  end
end

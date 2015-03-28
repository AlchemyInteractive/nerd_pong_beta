class UsersController < ApplicationController
  def front_page
    if session[:access_token] && !Bracket.all.select{|i| i.open}.empty?
      redirect_to brackets_path
      return
    end

    render :front
  end

  def authenticate
    username = params[:username]
    consumer_key = 'LDF6yywapOSQsL4rkIdUXTJ0c'
    consumer_secret = 'WVzrKPiHIapSQGAIxQqjwDOOdckdyt4UZrMOxjLly9SeEDrMkv'
  end
  
  def oauth_callback
    render 'update_user'
  end
  
  def update_user; end
end

class BracketsController < ApplicationController

  def index
    user = User.create(name: params[:name])
    game = Bracket.new(bracket: "{1=>[]}")  
    game = eval(game.bracket)
    game[1].push(
  end
end

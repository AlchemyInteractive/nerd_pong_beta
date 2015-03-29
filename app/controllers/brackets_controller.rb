class BracketsController < ApplicationController
  def index
    # if User.where(name: "jack").empty?
    #   @user = User.create(name: "jack")
    # end 
    @user = User.all
    b = Bracket.all.detect{|i| i.open == true} 

    if b
      check = check_for_user_in_bracket(@user, eval(b.bracket))

    else
      check = false
    end

    if check == false 
      @game = Bracket.new(bracket: "{1=>[[]]}")  
      @game = eval(@game.bracket)

      spot = 0  
      while true
        if @game[1][spot].count < 2 
          @game[1][spot].push(@user)
          break
        else
          spot += 1
        end
      end
    elsif check == true 
      render :index     
    else 
      @nomore = "Cant Play with us"
      render :index 
    end
    
  end

  def check_for_user_in_bracket(user, bracket)
    bracket.each do |k,v| 
      v.each do |match|
        if match.include? user 
          return "already in there"
        end
      end
    end
    false
  end 


end

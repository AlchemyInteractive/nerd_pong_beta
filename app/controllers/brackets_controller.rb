class BracketsController < ApplicationController
  def index
    @user = current_user 
    @b = Bracket.all.detect{|i| i.open == true} 

    if @b
      check = check_for_user_in_bracket(@user, @b.bracket)
    else
      check = false
    end

    if @b && check == false 
     
      spot = 0 
      while true
        if @b.bracket[1].count == (spot + 1)
          if @b.bracket[1][spot].count < 2 
            @b.bracket[1][spot].push(@user)
            break
          else
            spot += 1
          end
        else
          @b.bracket[1].push([])
          if @b.bracket[1][spot].count < 2 
            @b.bracket[1][spot].push(@user)
            break
          else
            spot += 1
          end
        end
      end
      @b.save
      @game = @b
    elsif check == false 
      @game = Bracket.new( bracket: {1=>[[]]} ) 
      @bracket = @game.bracket
      spot = 0 
      while true
        if @bracket[1][spot].count < 2 
          @bracket[1][spot].push(@user)
          break
        else
          spot += 1
        end
      end
      @game.bracket = @bracket
      @game.save
    elsif check == true 
      @game = @b
      render :index     
    else 
      @game = @b
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

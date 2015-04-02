class BracketsController < ApplicationController
  def index
    @user = current_user 
    @game = Bracket.all.detect{|i| i.open == true} 
    @game = Bracket.create(bracket: {1=>[]}, open: true) if !@game
    
    if !@game.active
      @game.queue.push(@user) if !@game.queue.include?(@user)
      @game.save
    else
      render :game_on
    end
  end
  
  def game_on; end

  def start_game
    @user = current_user 
    @game = Bracket.all.detect{|i| i.open == true} 
    if @game.active
      render :game_on
      return
    end
    @game.active = true
    players = @game.queue.count
    matches = (players/2 + players%2) 
    round = 1 

    while matches >= 1 
      @game.bracket[round] = [] if !@game.bracket[round]
      matches.times do
        @game.bracket[round].push([])
      end
      if matches == 1
        break
      end
      round += 1
      matches = (matches/2 + matches%2)
    end
    @game.randomize
    render :game_on
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
  
  def other
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
end

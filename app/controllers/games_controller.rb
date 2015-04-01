class GamesController < ApplicationController
  def save_score
    begin
      @bracket = Bracket.find(params[:data][:bracketId])
      @user1 = User.find(params[:data][:playerOne][:id]) if params[:data][:playerOne][:id]
      @user2 = User.find(params[:data][:playerTwo][:id]) if params[:data][:playerTwo][:id]
      @p1_score = params[:data][:playerOne][:score]
      @p2_score = params[:data][:playerTwo][:score]
    
      @winner_id = determine_winner(@p1_score, @user1, @p2_score, @user2)
      @loser_id = determine_loser(@p1_score, @user1, @p2_score, @user2)
      @round = params[:data][:curr_round]
    
      update_bracket(@bracket, @winner_id, @loser_id, @round)

      @game = Game.new(user1_id: @user1.id, user2_id: @user2.id, winner_id: @winner_id, user1_score: @p1_score, user2_score: @p2_score) 
    
      @json = {winner: @winner_id, loser: @loser_id}

      if @game.save
        respond_to do |format|
          format.json {render json: @json}
        end
      else 
        render status: 401
      end
    rescue => e
      respond_to do |format|
        format.json {render json: e, status: 401}
      end
    end
  end

  def determine_winner( p1, user1, p2, user2)
    p1 > p2 ? user1.id : user2.id
  end

  def determine_loser( p1, user1, p2, user2)
    p1 < p2 ? user1.id : user2.id
  end
  
  def update_bracket(bracket, winner, loser, round)
    @win_user = User.find(winner)
    @lose_user = User.find(loser)
    round = round.to_i
    bracket.bracket[round].each_with_index do |match, index|
      if match.include?(@win_user)
        advance_user(bracket, @win_user, index, round)
        return
      end
    end
  end
  
  def advance_user(bracket, winner, index, round)
    bracket.bracket[round].each_slice(2).to_a.each_with_index do |nxt_rd, index|
      if nxt_rd.flatten.include?(winner)  
        if bracket.bracket[round+1] 
          bracket.bracket[round+1][index].push(winner)
        else
          bracket.bracket[round+1] = bracket.bracket[round].each_slice(2).to_a.map(&:clear)
          bracket.bracket[round+1][index].push(winner)
        end
        bracket.save
      end
    end
  end
end

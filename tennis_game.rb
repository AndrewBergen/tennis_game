require 'test/unit'

class TennisTest < Test::Unit::TestCase
  
   def test_empty_game
    #Given I have an new tennis game
    game = TennisGame.new
    #When you check the score
    actual = game.score
    #Then the score should be love, love
    assert_equal("love - love", actual)
   end
   
   def test_player_1_scores_for_the_first_time
     #Given a scoreless game
     game = TennisGame.new
     #When player_1 scores
     actual = game.new_player_1_point
     #Then the score should be fifteen, love
     assert_equal('fifteen - love', actual)
     assert_equal(actual, game.score)
   end
   
   def test_player_2_scores_for_the_first_time
     #Given a scoreless game
     game = TennisGame.new
     #when player_2 scores
     actual = game.new_player_2_point
     #Then the score should be love, fifteen
     assert_equal('love - fifteen', actual)
     assert_equal(actual, game.score)
   end
   
   def test_when_player_1_has_2_points_and_player_2_is_scoreless
     #given a player has 1 point
     game = TennisGame.new
     game.new_player_1_point
     #When a player scores another point
     actual = game.new_player_1_point
     #Then that player's score should be 'thirty'
     assert_equal(actual, 'thirty - love')
     assert_equal(actual, game.score)
   end

   def test_when_player_1_has_3_points_and_player_2_is_scoreless
     #Given a player has 2 points
     game = TennisGame.new
     2.times {game.new_player_1_point}
     #When that player scores again
     actual = game.new_player_1_point
     #Then that player's score should be 'fourty'
     assert_equal(actual, 'fourty - love')
     assert_equal(actual, game.score)
   end
   
   def test_when_both_players_have_3_or_more_points_and_are_tied
      #Given a tennis game where both players have 3 or more points and are tied
      game = TennisGame.new
      3.times {game.new_player_1_point}
      
      3.times do 
        game.new_player_2_point
      end
      #When I call score
      actual = game.score
      #Then it should return 'deuce'
      assert_equal('deuce', actual)
   end
   
   def test_player_1_advantage
     #Given a tennis game where both players have 3 or more points and are tied
     game = TennisGame.new
     3.times do 
       game.new_player_1_point
       game.new_player_2_point
     end
     #When player 1 scores
     actual = game.new_player_1_point
     #Then it should return "advantage player 1"
     assert_equal("advantage player 1", actual)
   end
   
   def test_player_2_advantage
     #Given a tennis game where both players have 3 or more points and are tied
     game = TennisGame.new
     3.times do 
       game.new_player_1_point
       game.new_player_2_point
     end
     #When player 2 scores
     actual = game.new_player_2_point
     #Then it should return "advantage player 2"
     assert_equal("advantage player 2", actual)
   end

   def test_player_1_has_3_or_more_points_and_is_a_point_or_more_ahead_and_scores
     #Given a game where player 1 has 'fourty' and player 2 is behind a point or more
     game = TennisGame.new
     2.times do 
         game.new_player_1_point
         game.new_player_2_point
     end
     game.new_player_1_point
     #When player 1 scores
     actual = game.new_player_1_point
     #then it should return "game player 1"
     assert_equal(actual, "game player 1")
   end

   def test_player_2_has_3_or_more_points_and_is_a_point_or_more_ahead_and_scores
     #Given a game where player 1 has 'fourty' and player 2 is behind a point or more
     game = TennisGame.new
     2.times do 
         game.new_player_1_point
         game.new_player_2_point
     end
     game.new_player_2_point
     #When player 1 scores
     actual = game.new_player_2_point
     #then it should return "game player 1"
     assert_equal(actual, "game player 2")
   end

end   
 


class TennisGame
  def initialize
    @score = Score.new
  end
  
  def score
    @score.to_s
  end
  
  def new_player_1_point
    @score.increase_player_1
    score
  end
  
  def new_player_2_point
    @score.increase_player_2
    score
  end
  
end
  
class Score
  def initialize
    @score = [0, 0]
    @score_strings = ['love', 'fifteen', 'thirty', 'fourty']
  end

  def to_s
    if @score[0] >= 3 and @score[0] == @score[1] then
      "deuce"
    elsif @score[0] >= 3 and @score[1] >=3 and @score[0] - @score[1] == 1 then
      "advantage player 1"
    elsif @score[0] >= 3 and @score[1] >=3 and @score[0] - @score[1] == -1 then
      "advantage player 2"
    elsif @score[0] > 3 and @score[0] - @score[1] > 1 then
      "game player 1"
    elsif @score[1] > 3 and @score[0] - @score[1] < -1 then
      "game player 2"
    else
      @score_strings[@score[0]] + " - " + @score_strings[@score[1]]
    end
  end
  
  def increase_player_1
   @score[0] += 1
  end
  
  def increase_player_2
    @score[1] += 1
  end
  
end

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
      #This is a bit ugly. I could use a set_player_points function, but I don't see a use outside of my tests.
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

require 'test/unit'

class TennisTest < Test::Unit::TestCase
  
   def test_empty_game
    #Given I have an new tennis game
    game = TennisGame.new
    #When you check the score
    actual = game.score
    #Then the score should be love, love
    assert_equal(actual, ['love', 'love'])
   end
   
   def test_player_1_scores_for_the_first_time
     #Given a scoreless game
     game = TennisGame.new
     #When player_1 scores
     actual_p1, actual_p2 = game.new_player_1_point
     #Then the score should be fifteen, love
     assert_equal(actual_p1, 'fifteen')
     assert_equal(actual_p2, 'love')
     assert_equal([actual_p1, actual_p2], game.score)
   end
   
   def test_player_2_scores_for_the_first_time
     #Given a scoreless game
     game = TennisGame.new
     #when player_2 scores
     actual_p1, actual_p2 = game.new_player_2_point
     #Then the score should be love, fifteen
     assert_equal(actual_p1, 'love')
     assert_equal(actual_p2, 'fifteen')
     assert_equal([actual_p1, actual_p2], game.score)
   end
   
   def test_when_a_player_has_2_points
     #given a player has 1 point
     game = TennisGame.new
     game.new_player_1_point
     #When a player scores another point
     actual_p1, actual_p2 = game.new_player_1_point
     #Then that player's score should be 'thirty'
     assert_equal(actual_p1, 'thirty')
     assert_equal([actual_p1, actual_p2], game.score)
   end

   def test_when_a_player_has_3_points
     #Given a player has 2 points
     game = TennisGame.new
     game.new_player_1_point
     game.new_player_1_point
     #When that player scores again
     actual_p1, actual_p2 = game.new_player_1_point
     #Then that player's score should be 'fourty'
     assert_equal(actual_p1, 'fourty')
     assert_equal([actual_p1,actual_p2], game.score)
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
      actual_p1, actual_p2 = game.score
      #Then it should return 'deuce'
      assert_equal('deuce', [actual_p1,actual_p2])
   end
   
end

class TennisGame
  def initialize
    @score_1 = Score.new
    @score_2 = Score.new
  end
  
  def score
    [@score_1.to_s, @score_2.to_s]
  end
  
  def new_player_1_point
    @score_1.increase
    score
  end
  
  def new_player_2_point
    @score_2.increase
    score
  end
  
end
  
class Score
  def initialize
    @score = 0
  end

  def to_s
    if @score == 0 
      'love'
    elsif @score == 2
      'thirty'
    elsif @score == 3
      'fourty'
    else
      'fifteen'
    end
  end
  
  def increase
   @score += 1
  end
  
end

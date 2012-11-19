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
     actual_p1, actual_p2 = game.new_player_1_point()
     #Then the score should be fifteen, love
     assert_equal(actual_p1, 'fifteen')
     assert_equal(actual_p2, 'love')
     assert_equal([actual_p1, actual_p2], game.score)
   end
   
   def test_player_2_scores_for_the_first_time
     #Given a scoreless game
     game = TennisGame.new
     #when player_2 scores
     actual_p1, actual_p2 = game.new_player_2_point()
     #Then the score should be love, fifteen
     assert_equal(actual_p1, 'love')
     assert_equal(actual_p2, 'fifteen')
     assert_equal([actual_p1, actual_p2], game.score)
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
    else
      'fifteen'
    end
  end
  
  def increase
   @score += 1
  end
  
end

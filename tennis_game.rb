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
     actual_p1, actual_p2 = game.new_player_point()
     #Then the score should be fifteen, love
     assert_equal(actual_p1, 'fifteen')
     assert_equal(actual_p2, 'love')
     assert_equal([actual_p1, actual_p2], game.score)
   end
   
end

class TennisGame
  def initialize
    @score = ['love','love']
  end
  
  def score
    @score
  end
  
  def new_player_point
    ['fifteen', 'love']
  end
  
end
  
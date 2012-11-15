require 'test/unit'

class TennisTest < Test::Unit::TestCase
  
   def test_empty_game
    #Given I have an new tennis game
    game = TennisGame.new
    #When you check the score
    actual = game.score
    #Then the score should be 0 to 0
    assert_equal(actual, 0)
   end
   
end

class TennisGame
  def score
    0
  end
end
  
# wumpus_test.rb

# gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require_relative '../app/wumpus'

class WumpusTest < Minitest::Test
  def setup
    @game = WumpusGame.new
    @player = @game.player
  end

  def test_adjoining_room_1
    assert_equal [2, 5, 8], @game.rooms[1].adjoining_rooms
  end

  def test_adjoining_rooms_2_3_4
    skip
    assert_equal [1, 3, 10], @game.rooms[2].adjoining_rooms
    assert_equal [2, 4, 12], @game.rooms[3].adjoining_rooms
    assert_equal [3, 5, 14], @game.rooms[4].adjoining_rooms
  end

  def test_adjoining_rooms_5_to_20
    skip
    multiple_adjoining_rooms = (5..20).map do |room| 
      @game.rooms[room].adjoining_rooms
    end
    expected_rooms = [
      [1, 4, 6], [5, 7, 15], [6, 8, 17], [1, 7, 11],
      [10, 12, 19], [2, 9, 11], [8, 10, 20], [3, 9, 13],
      [12, 14, 18], [4, 13, 15], [6, 14, 16], [15, 17, 18],
      [7, 16, 20], [13, 16, 19], [9, 18, 20], [11, 17, 19]
    ]

    assert_equal expected_rooms, multiple_adjoining_rooms
  end

  # Maybe the movement tests are maybe a little too opinionated?

  def test_move_options_room_1
    skip
    @player.position = 1
    action_response = @player.action(m)
    expected_response = "Adjoining rooms are 2, 5 and 8. "
      + "Please choose a room to move to."

    assert_equal expected_response, action_response
  end

  def test_move_options_room_2
    skip
    @player.position = 2
    action_response = @player.action(m)
    expected_response = "Adjoining rooms are 1, 3 and 10. "
      + "Please choose a room to move to."

    assert_equal expected_response, action_response
  end

  def test_valid_move_room_1_to_2
    skip
    @player.position = 1
    move_response = @player.move(2)
    expected_response = "You are now in room 2. "
      + "Adjoining rooms are 2, 5 and 8. "
      + "Do you want to move (m) or shoot (s)?"

    assert_equal expected_response, move_response
  end

  def test_valid_move_room_19_to_20
    skip
    @player.position = 19
    move_response = @player.move(20)
    expected_response = "You are now in room 20. "
      + "Adjoining rooms are 11, 17 and 19. "
      + "Do you want to move (m) or shoot (s)?"

    assert_equal expected_response, move_response
  end

  def test_invalid_move_room_1_to_20
    skip
    @player.position = 1
    move_response = @player.move(20)
    expected_response = "You cannot move there! "
      + "Adjoining rooms are 11, 17 and 19. "
      + "Please choose a room to move to."

    assert_equal expected_response, move_response
  end
end

# wumpus_game.rb

require './app/game'
require './app/utilities'

# This class is responsible for directing the flow the game. That includes:
# => Getting user input from the terminal
# => Passing that input along to the Game class
# => Outputting the appropriate messages to the terminal based on the state of the Game
# => Terminating the Game appropriately

class WumpusGame
  include Utilities

  def initialize
    @game = Game.new
  end

  def start
    fancy_output 'Welcome to Hunt the Wumpus!'
    enter_to_continue
    display_nearby_room_messages
    
    loop do
      display_current_room
      choice = get_move_choice
      choice == 'm' ? player_move : player_shoot
      display_move_outcome if choice == 'm'
      break if game_over?
      display_nearby_room_messages
    end
    
    display_final_result
    fancy_output 'Thanks for Playing Hunt the Wumpus. Goodbye!'
  end

  private

  attr_reader :game

  def get_move_choice # User decides whether to move or shoot
    if game.player_can_shoot?
      message = 'What would you like to do? (s)hoot or (m)ove:'
      get_input(message, choices: ['m', 's'])
    else
      'm'
    end
  end

  def player_move
    room_choices = game.adjoining_rooms.map(&:to_s)
    message = "Pick a room to move to: #{room_choices.join(', ')}"
    room_number = get_input(message, choices: room_choices, number: true)
    game.move_player(room_number)
  end

  # Methods related to Shooting an Arrow
  def player_shoot
    distance = choose_shot_distance
    room_number = set_room_target(distance)
    game.shoot_arrow(room_number)
    animate('>>>--------~>')
  end

  def choose_shot_distance
    message = 'Choose a shot distance in number of rooms from 1-5'
    choices = [1, 2, 3, 4, 5].map(&:to_s)
    get_input(message, choices: choices, number: true)
  end

  def set_room_target(distance)
    room_number = game.player_current_room.number
    distance.times do
      room_choices = game.adjoining_rooms(room_number).map(&:to_s)
      message = "Draw your arrow path by selecting a room: #{room_choices.join(', ')}"
      choice = get_input(message, choices: room_choices, number: true)
      room_number = choice
    end
    room_number
  end

  # Methods for displaying messages to the terminal
  def display_nearby_room_messages
    game.nearby_room_messages.each { |message| fancy_output message }
  end

  def display_current_room
    room_number = game.player_current_room
    fancy_output "You are currently in room #{room_number}"
  end

  def display_move_outcome
    fancy_output game.move_outcome_message
  end

  def display_final_result
    fancy_output game.final_result if game.final_result
  end

  def game_over?
    game.over?
  end
end

WumpusGame.new.start
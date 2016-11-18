# wumpus_game.rb

require './app/game'
require './app/utilities'
require './app/messages'
require './app/validated_input'

# This class handles I/O and directs the flow of the
# game based on the @state of the Game class.
class WumpusGame
  include Utilities
  include Messages
  include ValidatedInput

  def initialize
    @game = Game.new
  end

  def start
    display_introduction
    enter_to_continue
    until @game.over?
      display_nearby_room_messages
      display_current_room
      choice = player_move_choice
      choice == 'm' ? player_move : player_shoot
      display_move_outcome
    end
    display_goodbye_message
  end

  private

  def player_move_choice
    return 'm' unless @game.player_can_shoot?
    get_input(move_choice_message, choices: %w(m s))
  end

  def player_move
    room_choices = @game.adjoining_rooms.map(&:to_s)
    message = pick_a_room_message(room_choices.join(', '))
    room_number = get_input(message, choices: room_choices, number: true)
    @game.move_player(room_number)

    @game.move_player if @game.carried_by_bats?
  end

  # Methods related to Shooting an Arrow
  def player_shoot
    distance = choose_shot_distance
    room_number = choose_room_target(distance)
    @game.shoot_arrow(room_number)
    animate('>>>--------~>')
  end

  def choose_shot_distance
    choices = [1, 2, 3].map(&:to_s)
    get_input(shot_distance_message, choices: choices, number: true)
  end

  def choose_room_target(distance)
    room_choices = @game.rooms_within_range(distance)
    message = room_target_message(room_choices.join(', '))
    get_input(message, choices: room_choices, number: true)
  end

  # Methods for displaying messages to the terminal
  def display_nearby_room_messages
    puts @game.nearby_room_messages
  end

  def display_current_room
    room_number = @game.player_current_room
    display_current_room_message(room_number)
  end

  def display_move_outcome
    outcomes = [@game.state].flatten
    outcomes.each { |outcome| send("display_#{outcome}_message") }
  end

  def display_introduction
    display_welcome_message
    input = get_input(instructions_message, choices: %w(y n))
    if input == 'y'
      instructions = File.readlines('assets/instructions.txt')
      instructions.each do |line|
        puts line
        sleep(0.2)
      end
    end
  end
end

WumpusGame.new.start

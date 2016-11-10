require_relative 'map'
require_relative 'player'

class Game
  attr_reader :player, :wumpus, :map

  def initialize
    @map = Map.new
    @player = Player.new
    @wumpus = nil
    place_player
  end

  def move_player(room_number)
    room = map.rooms(room_number)
    player.move(room)
    update_result
  end

  def shoot_arrow(room_number)
    player.shoot
    room = map.rooms(room_number)
    result_of_shot = room.incoming_arrow
    @wumpus = :dead if result_of_shot == :hit
    update_result
  end

  def move_outcome_message
    player.current_room.move_outcome[:message]
  end

  def update_result
    outcome = player.current_room.move_outcome
    
    if outcome[:result] == :dead
      player.kill
    elsif outcome[:result] == :carried
      new_room = @map.rooms(rand(1..20))
      player.move(new_room)
      update_result
    end
  end

  def nearby_room_messages
    messages = adjoining_rooms.map(&:message)
    messages.compact.uniq
  end

  def over?
    player.dead? || player.out_of_arrows? || wumpus == :dead
  end

  def final_result
    if player.out_of_arrows?
      'You ran out of arrows and lost the game.'
    elsif wumpus == :dead
      'You killed the Wumpus and won the game.'
    end
  end

  def player_current_room
    player.current_room
  end

  def player_can_shoot?
    player.can_shoot?
  end

  def adjoining_rooms(room_number = nil)
    if room_number
      rooms = @map.rooms(room_number).adjoining_rooms
      rooms.map { |num| @map.rooms(num) }
    else
      player.adjoining_rooms.map { |num| @map.rooms(num) }
    end
  end

  private

  def place_player
    starting_room = @map.empty_rooms.sample
    @player.move(starting_room)
  end
end

# wumpus.rb

require_relative 'map'
require_relative 'room'
require_relative 'player'

class WumpusGame

  attr_accessor :player, :map
  
  def initialize
    @map = Map.new
    @player = Player.new
    place_player
  end
  
  def place_player
    player.current_room = map.empty_rooms.sample
  end

  def player_action(action_choice)
    if action_choice == 'm'
      nearby_rooms_string + "Please choose a room to move to."
    else
      ""
    end
  end

  def move_player(room_number)
    if @player.current_room.adjoining_rooms.include?(room_number)
      player.move(@map.rooms[room_number])
      "You are now in room #{room_number}. " + 
      nearby_rooms_string + 
      "Do you want to move (m) or shoot (s)?"
    else
      "You cannot move there! " +
      nearby_rooms_string +
      "Please choose a room to move to."
    end
  end

  def nearby_rooms_string
    room_numbers = player.current_room.adjoining_rooms.join(', ')
    "Adjoining rooms are #{room_numbers}. "
  end
end

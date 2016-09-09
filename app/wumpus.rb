# wumpus.rb

class WumpusGame
  
  
  attr_accessor :player, :map
  
  def initialize
    @map = Map.new
    @player = Player.new
    place_player
  end
  
  def place_player
    player.current_room = map.random_room
  end
end

class Map
  attr_reader :rooms
  
  ADJOINING_ROOMS = {
    1 => [2, 5, 8], 2 => [1, 3, 10], 3 => [2, 4, 12], 4 => [3, 5, 14],
    5 => [1, 4, 6], 6 => [5, 7, 15], 7 => [6, 8, 17], 8 => [1, 7, 11],
    9 => [10, 12, 19], 10 => [2, 9, 11], 11 => [8, 10, 20], 12 => [3, 9, 13],
    13 => [12, 14, 18], 14 => [4, 13, 15], 15 => [6, 14, 16], 16 => [15, 17, 18],
    17 => [7, 16, 20], 18 => [13, 16, 19], 19 => [9, 18, 20], 20 => [11, 17, 19]
  }
  
  def initialize
    @rooms = create_rooms
    # place_hazards
  end

  def create_rooms
    rooms = {}
    (1..20).each do |num| 
      rooms[num] = Room.new(num, ADJOINING_ROOMS[num])
    end
    rooms
  end
  
  def random_room
    number = rooms.keys.sample
    rooms[number]
  end
end

class Room
  attr_reader :adjoining_rooms, :number
  
  def initialize(num, adjoining_rooms)
    @number = num
    @adjoining_rooms = adjoining_rooms
  end
  
end

class Player
  attr_accessor :current_room
  
  def initialize
    @current_room = nil
  end
  
  def action(choice)
    if choice == 'move'
      nearby_rooms_string + "Please choose a room to move to."
    else
      ""
    end
  end
  
  def nearby_rooms_string
    room_numbers = current_room.adjoining_rooms.join(', ')
    "Adjoining rooms are #{room_numbers}. "
  end
end
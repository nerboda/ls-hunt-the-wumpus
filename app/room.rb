# room.rb

class Room
  attr_reader :adjoining_rooms, :number
  attr_accessor :hazard

  def initialize(room_number, adjoining_rooms)
    @room_number, @adjoining_rooms = room_number, adjoining_rooms
  end

  def has_pit?
    hazard == :pit
  end

  def has_bat?
    hazard == :bat
  end

  def has_wumpus?
    hazard == :wumpus
  end

  def safe?
    !hazard
  end
end

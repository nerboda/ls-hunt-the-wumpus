# player.rb

class Player
  attr_accessor :current_room
  
  def initialize
    @current_room = nil
  end

  def move(room)
    @current_room = room
  end
end

# utilities.rb

# Some utility methods for use throughout the game
module Utilities
  def enter_to_continue
    puts 'Hit enter to continue.'
    gets.chomp
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def delay(msg)
    print msg
    25.times do
      print '.'
      sleep(0.03)
    end
    puts
  end

  def animate(object)
    40.times do |n|
      clear_screen
      puts ' ' * n + object
      sleep(0.02)
    end
    clear_screen
  end
end

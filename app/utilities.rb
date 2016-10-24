# Some utility methods for use throughout the game
module Utilities
  def get_input(message, options = {})
    default_error = 'That was an invalid input.'
    error_message = options.fetch(:err_msg, default_error)
    choices = options[:choices]
    input = ''
    loop do
      prompt message
      input = gets.chomp.strip
      if options
        break if choices.map(&:downcase).include? input.downcase
      else
        break unless input.empty?
      end
      puts error_message
    end
    options[:number] ? input.to_i : input
  end

  def enter_to_continue
    prompt 'Hit enter to continue.'
    gets.chomp
  end

  def prompt(message)
    puts "==> #{message}"
  end

  def fancy_output(message)
    puts ">>> #{message}"
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

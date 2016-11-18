# validated_input.rb

# Provides a single get_input method that loops until the input is valid
module ValidatedInput
  DEFAULT_ERROR = 'That was an invalid input.'.freeze

  # options can include:
  # => :choices : an array of the valid choices
  # => :err_msg : an error message string. Default is used if none given
  # => :number : if { number: true } is passed, output is converted to integer
  def get_input(message, options = {})
    error_message = options.fetch(:err_msg, DEFAULT_ERROR)
    input = ''

    puts message
    loop do
      input = gets.chomp.strip
      break if valid?(input, options)
      puts error_message
    end

    format_output(input, options)
  end

  private

  def format_output(input, options)
    if options[:number]
      input.to_i
    else
      input
    end
  end

  def valid?(input, options)
    choices = options[:choices]
    choices.map(&:downcase).include? input.downcase
  end
end

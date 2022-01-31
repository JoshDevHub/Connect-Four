# frozen_string_literal: true

require_relative 'display'

# module for managing user command line inputs
module UserInput
  include Display

  def give_yes_no_input
    error = error_message(:not_yn)
    user_input(error, &yes_no_validator)
  end

  def yes_no_validator
    ->(input) { %w[y n].include?(input) }
  end

  def user_input(error_msg, &validator)
    loop do
      input = gets.strip
      return input if validator.call(input)

      puts error_msg
    end
  end
end

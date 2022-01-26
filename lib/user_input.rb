# frozen_string_literal: true

require_relative 'display'

# module for managing user command line inputs
module UserInput
  include Display

  def give_yes_no_input
    validate_user_input(&yes_no_validator)
  end

  def yes_no_validator
    lambda do |input|
      if %w[y n].none?(input)
        puts error_message(:not_yn)
      else
        true
      end
    end
  end

  def validate_user_input(&validator)
    input = gets.chomp
    return input if validator.call(input)

    validate_user_input(&validator)
  end
end

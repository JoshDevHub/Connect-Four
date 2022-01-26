# frozen_string_literal: true

# module for managing user command line inputs
module UserInput
  def give_yes_no_input
    validate_user_input(&yes_no_validator)
  end

  def yes_no_validator
    lambda do |input|
      if %w[y n].none?(input)
        error_message(:not_yn)
        false
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

# frozen_string_literal: true

require_relative 'display'

# class that holds logic for the game's players
class Player
  include Display

  def user_selection
    selection = take_input
    return selection if valid_selection?(selection)

    # puts error_message(:not_in_range)
    puts 'That input is not in the range of columns you can place your piece in. Try again.'
    user_selection
  end

  def take_input
    gets.chomp
  end

  def valid_selection?(selection)
    valid_range = ('1'..'7')
    valid_range.include?(selection)
  end
end

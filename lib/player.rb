# frozen_string_literal: true

require_relative 'display'
# class that holds logic for the game's players
class Player
  include Display
  attr_reader :disc

  def initialize(disc_token)
    @disc = disc_token
  end

  def user_selection
    selection = take_input
    return selection if valid_selection?(selection)

    puts error_message(:not_in_range)
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

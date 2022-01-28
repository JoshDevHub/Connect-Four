# frozen_string_literal: true

require_relative 'display'
require_relative 'user_input'

# class that holds logic for the game's players
class Player
  include Display
  include UserInput
  attr_reader :disc, :name

  @player_counter = 0

  def initialize(disc_token: nil)
    @disc = disc_token
    @name = "Player #{self.class.count}"
  end

  def input_name
    puts "#{name}, #{query_message(:player_name)}"
    user_name = validate_user_input(&name_validator)
    @name = user_name
  end

  def to_s
    name
  end

  def self.count
    @player_counter += 1
  end

  def name_validator
    lambda do |input|
      if /^[a-zA-Z]+$/.match?(input)
        true
      else
        puts error_message(:invalid_name)
      end
    end
  end
end

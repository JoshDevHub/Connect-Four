# frozen_string_literal: true

require_relative 'display'
require_relative 'user_input'

# class that holds logic for the game's players
class Player
  include Display
  include UserInput
  attr_reader :disc, :name

  @player_counter = 0
  @chosen_discs = []

  class << self
    attr_reader :chosen_discs
  end

  def self.count
    @player_counter += 1
  end

  def self.add_choice(choice)
    @chosen_discs << choice
  end

  def initialize
    @disc = nil
    @name = "Player #{self.class.count}"
  end

  DISCS = {
    yellow: '🟡',
    red: '🔴',
    orange: '🟠',
    green: '🟢',
    blue: '🔵',
    purple: '🟣'
  }.freeze

  def setup
    input_name
    choose_disc
  end

  def input_name
    puts "#{name}, #{query_message(:player_name)}"
    error = error_message(:invalid_name)
    user_name = user_input(error, &name_validator)
    @name = user_name
  end

  def choose_disc
    print_discs(DISCS.values)
    puts "#{name}, #{query_message(:disc_choice)}"
    error = error_message(:invalid_disc)
    disc_choice = user_input(error, &disc_validator)
    self.class.add_choice(disc_choice)
    @disc = DISCS[disc_choice.to_sym]
    puts disc_message(disc)
  end

  def to_s
    name
  end

  private

  def name_validator
    ->(input) { /^[a-zA-Z]+$/.match?(input) && input.size < 20 }
  end

  def disc_validator
    lambda do |input|
      input.downcase!
      self.class.chosen_discs.none?(input) && DISCS.key?(input.to_sym)
    end
  end
end

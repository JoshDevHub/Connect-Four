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
    user_name = validate_user_input(&name_validator)
    @name = user_name
  end

  def choose_disc
    puts "#{name}, #{query_message(:disc_choice)}"
    disc_choice = validate_user_input(&disc_validator)
    self.class.add_choice(disc_choice)
    @disc = DISCS[disc_choice.to_sym]
  end

  def to_s
    name
  end

  private

  def self.count
    @player_counter += 1
  end

  def self.add_choice(choice)
    @chosen_discs << choice
  end

  def name_validator
    lambda do |input|
      if /^[a-zA-Z]+$/.match?(input) && input.size < 20
        true
      else
        puts error_message(:invalid_name)
      end
    end
  end

  def disc_validator
    lambda do |input|
      if self.class.chosen_discs.include?(input)
        puts error_message(:chosen_disc)
      elsif DISCS.key?(input.to_sym)
        true
      else
        puts error_message(:invalid_disc)
      end
    end
  end
end

# frozen_string_literal: true

require 'pry-byebug'
# class that represents the game board
class Board
  attr_reader :board_grid

  def initialize
    @board_grid = create_board
  end

  # TODO: column full?
  def place_disc(color, column)
    x_pos = column.to_i - 1
    y_pos = 0
    key_pointer = [x_pos, y_pos]
    y_pos += 1 until board_grid[key_pointer].nil?
    board_grid[key_pointer] = color
  end

  private

  def create_board
    board_hash = {}
    6.times do |y|
      7.times do |x|
        board_hash[[x, y]] = nil
      end
    end
    board_hash
  end
end

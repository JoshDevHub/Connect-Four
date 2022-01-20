# frozen_string_literal: true

# class that represents the game board
class Board
  attr_reader :board_grid

  def initialize
    @board_grid = create_board
  end

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

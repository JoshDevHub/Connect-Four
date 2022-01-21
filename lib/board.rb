# frozen_string_literal: true

require 'matrix'
require 'pry-byebug'
# class that represents the game board
class Board
  attr_reader :board_grid

  def initialize
    @board_grid = create_board
  end

  def place_disc(color, column)
    x = column.to_i - 1 # TODO: consider abstraction or placement?
    y = 0
    y += 1 until board_grid[[x, y]].nil?
    board_grid[[x, y]] = color
  end

  def column_full?(column)
    x = column.to_i - 1
    all_columns[x].none?(&:nil?)
  end

  def connect_four?(disc)
    (all_columns + all_rows).any? { |section| four_consecutive?(section, disc) }
  end

  def test_diagonal
    # placeholder
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

  # TODO: rename
  def four_consecutive?(subsection, disc)
    connect = false
    subsection.each_cons(4) do |cons4|
      connect = true if cons4.all? { |slot| slot == disc }
    end
    connect
  end

  def all_rows
    row_coords = []
    6.times do |i|
      row = (0..6).to_a.product([i]).map { |ndx| board_grid[ndx] }
      row_coords << row
    end
    row_coords
  end

  def all_columns
    all_rows.transpose
  end
end

p Board.new.test_diagonal

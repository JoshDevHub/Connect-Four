# frozen_string_literal: true

require 'pry-byebug'
# class that represents the game board
class Board
  attr_reader :board_grid

  def initialize
    @board_grid = create_board
  end

  WIDTH = 7
  HEIGHT = 6

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
    all_conditions = (all_columns + all_rows + main_diagonals + anti_diagonals)
    all_conditions.any? { |section| four_consecutive?(section, disc) }
  end

  def to_s
    board_array = all_rows.reverse.flatten.map { |position| position.nil? ? '..' : position }
    row_separator = '|----+----+----+----+----+----+----|'
    board_string = ''
    board_array.each_slice(WIDTH) { |row| board_string += "| #{row.join(' | ')} |\n#{row_separator}\n" }
    board_string
  end

  private

  def create_board
    board_hash = {}
    HEIGHT.times do |y|
      WIDTH.times do |x|
        board_hash[[x, y]] = nil
      end
    end
    board_hash
  end

  def four_consecutive?(subsection, disc)
    connect = false
    subsection.each_cons(4) do |cons4|
      connect = true if cons4.all? { |slot| slot == disc }
    end
    connect
  end

  def all_rows
    row_coords = []
    HEIGHT.times do |i|
      row = (0..HEIGHT).to_a.product([i]).map { |ndx| board_grid[ndx] }
      row_coords << row
    end
    row_coords
  end

  def all_columns
    all_rows.transpose
  end

  def traverse_diagonally(coordinate, main:)
    x, y = coordinate
    results = []
    until x >= WIDTH || y >= HEIGHT
      results << board_grid[[x, y]]
      main ? x += 1 : x -= 1
      y += 1
    end
    results
  end

  def main_diagonals
    origins = [[0, 0], [1, 0], [2, 0], [3, 0], [0, 1], [0, 2]]
    diagonals = []
    origins.each { |origin| diagonals << traverse_diagonally(origin, main: true) }
    diagonals
  end

  def anti_diagonals
    origins = [[3, 0], [4, 0], [5, 0], [6, 0], [6, 1], [6, 2]]
    diagonals = []
    origins.each { |origin| diagonals << traverse_diagonally(origin, main: false) }
    diagonals
  end
end

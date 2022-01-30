# frozen_string_literal: true

require 'pry-byebug'
# class that represents the game board
class Board
  attr_reader :board_grid

  def initialize
    @board_grid = Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  WIDTH = 7
  HEIGHT = 6

  def place_disc(disc, column)
    x = column.to_i - 1
    y = 0
    y += 1 until board_grid[y][x].nil?
    board_grid[y][x] = disc
  end

  def column_full?(column)
    x = column.to_i - 1
    all_columns[x].none?(&:nil?)
  end

  def connect_four?(disc)
    all_conditions = (board_grid + all_columns + diagonals + diagonals(main: false))
    all_conditions.any? { |section| four_consecutive?(section, disc) }
  end

  def full_board?
    board_grid.none? { |row| row.include?(nil) }
  end

  def to_s
    board_array = board_grid.reverse.flatten.map { |position| position.nil? ? '..' : position }
    row_separator = '|----+----+----+----+----+----+----|'
    board_string = ''
    board_array.each_slice(WIDTH) { |row| board_string += "| #{row.join(' | ')} |\n#{row_separator}\n" }
    board_string
  end

  private

  def four_consecutive?(subsection, disc)
    connect = false
    subsection.each_cons(4) do |cons4|
      connect = true if cons4.all? { |slot| slot == disc }
    end
    connect
  end

  def all_columns
    board_grid.transpose
  end

  def get_diagonal_lines(coordinate, grid)
    x, y = coordinate
    results = []
    until x >= WIDTH || y >= HEIGHT
      results.push(grid[y][x])
      x += 1
      y += 1
    end
    results
  end

  def diagonals(main: true)
    grid = main ? board_grid.map(&:reverse) : board_grid
    diagonal_lines = []
    diagonal_origins.each { |origin| diagonal_lines << get_diagonal_lines(origin, grid) }
    diagonal_lines
  end

  def diagonal_origins
    origins = []
    x_max = WIDTH - 4
    y_max = HEIGHT - 4
    (0..x_max).each { |x| origins << [x, 0] }
    (1..y_max).each { |y| origins << [0, y] }
    origins
  end
end

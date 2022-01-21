# frozen_string_literal: true

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
    columns[x].none?(&:nil?)
  end

  def connect_four?(disc)
    columns.any? { |column| connect_four(column, disc) }
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

  def connect_four(subsection, disc)
    connect = false
    subsection.each_cons(4) do |cons4|
      connect = true if cons4.all? { |slot| slot == disc }
    end
    connect
  end

  def columns
    column_coords = []
    7.times do |i|
      column = [i].product((0..5).to_a).map { |ndx| board_grid[ndx] }
      column_coords << column
    end
    column_coords
  end
end

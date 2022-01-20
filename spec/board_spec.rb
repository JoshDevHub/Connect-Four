# frozen_string_literal: true

require_relative '../lib/board'

describe Board do # rubocop: disable Metrics/BlockLength
  subject(:board) { described_class.new }

  describe '#place_disc' do # rubocop: disable Metrics/BlockLength
    context 'when the board is empty' do
      context 'when the color is red' do
        disc_color = 'red'
        it 'places a red disc in column 1 of the board' do
          column = '1'
          coordinate = [0, 0]
          board.place_disc(disc_color, column)
          expect(board.board_grid[coordinate]).to eq(disc_color)
        end

        it 'places a red disc in column 5 of the board' do
          column = '5'
          coordinate = [4, 0]
          board.place_disc(disc_color, column)
          expect(board.board_grid[coordinate]).to eq(disc_color)
        end
      end

      context 'when the color is yellow' do
        disc_color = 'yellow'
        it 'places a yellow disc in column 3 of the board' do
          column = '3'
          coordinate = [2, 0]
          board.place_disc(disc_color, column)
          expect(board.board_grid[coordinate]).to eq(disc_color)
        end
      end
    end
  end
end

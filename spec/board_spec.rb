# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#place_disc' do
    context 'when the board is empty' do
      context 'when the color is red' do
        disc_color = 'red'
        it 'places a red disc in column 1 of the board' do
          column = '1'
          coordinate = [0, 0]
          expect(board.board_grid[coordinate]).to eq(disc_color)
          board.place_disc(disc_color, column)
        end

        it 'places a red disc in column 5 of the board' do
          column = '5'
          coordinate = [4, 0]
          expect(board.board_grid[coordinate]).to eq(disc_color)
          board.place_disc(disc_color, column)
        end
      end
    end
  end
end

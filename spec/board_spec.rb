# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#place_disc' do
    context 'when the color of the disc is red' do
      disk_color = 'red'

      it 'places a red disc at coordinate (2, 3) of the board' do
        location = [2, 3]
        expect(board.board_grid[location]).to eq(disk_color)
        board.place_disc(disc_color, location)
      end

      it 'places a red disc at coordinate (5, 2) of the board' do
        location = [5, 2]
        expect(board.board_grid[location]).to eq(disk_color)
        board.place_disc(disc_color, location)
      end
    end
  end
end

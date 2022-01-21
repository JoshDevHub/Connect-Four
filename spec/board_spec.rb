# frozen_string_literal: true

require_relative '../lib/board'

describe Board do # rubocop: disable Metrics/BlockLength
  # subject(:board) { described_class.new }

  describe '#place_disc' do # rubocop: disable Metrics/BlockLength
    subject(:board) { described_class.new }
    context 'when the column is empty' do
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

    context 'when the first column is partially full' do
      before do
        partial_board = {
          [0, 0]=>'red', [1, 0]=>nil, [2, 0]=>nil, [3, 0]=>nil, [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
          [0, 1]=>'yellow', [1, 1]=>nil, [2, 1]=>nil, [3, 1]=>nil, [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
          [0, 2]=>'red', [1, 2]=>nil, [2, 2]=>nil, [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
          [0, 3]=>'red', [1, 3]=>nil, [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
          [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
          [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
        }
        board.instance_variable_set(:@board_grid, partial_board)
      end
      it 'places a red disc in column 1' do
        disc_color = 'red'
        column = '1'
        coordinate = [0, 4]
        board.place_disc(disc_color, column)
        expect(board.board_grid[coordinate]).to eq(disc_color)
      end
    end

    context 'when the fourth column is partially full' do
      before do
        partial_board = {
          [0, 0]=>nil, [1, 0]=>nil, [2, 0]=>nil, [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
          [0, 1]=>nil, [1, 1]=>nil, [2, 1]=>nil, [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
          [0, 2]=>nil, [1, 2]=>nil, [2, 2]=>nil, [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
          [0, 3]=>nil, [1, 3]=>nil, [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
          [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
          [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
        }
        board.instance_variable_set(:@board_grid, partial_board)
      end
      it 'places a yellow disc in column 4' do
        disc_color = 'yellow'
        column = '4'
        coordinate = [3, 2]
        board.place_disc(disc_color, column)
        expect(board.board_grid[coordinate]).to eq(disc_color)
      end
    end
  end

  describe '#column_full?' do
    context 'when none of the columns are full' do
      subject(:board_column_space) { described_class.new }
      before do
        partial_board = {
          [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
          [0, 1]=>'yellow', [1, 1]=>nil, [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
          [0, 2]=>nil, [1, 2]=>nil, [2, 2]=>'red', [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
          [0, 3]=>nil, [1, 3]=>nil, [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
          [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
          [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
        }
        board_column_space.instance_variable_set(:@board_grid, partial_board)
      end
      it 'returns false when no column is full' do
        expect(board_column_space.column_full?).to be(false)
      end
    end
  end
end

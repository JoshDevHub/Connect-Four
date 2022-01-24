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

  describe '#column_full?' do # rubocop: disable Metrics/BlockLength
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
      it "returns false when column 3 isn't full" do
        column = '3'
        expect(board_column_space.column_full?(column)).to be(false)
      end
    end
    context 'when a column is full' do
      subject(:board_full_column) { described_class.new }
      before do
        board_with_full_col = {
          [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
          [0, 1]=>'yellow', [1, 1]=>'yellow', [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
          [0, 2]=>nil, [1, 2]=>'red', [2, 2]=>'red', [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
          [0, 3]=>nil, [1, 3]=>'yellow', [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
          [0, 4]=>nil, [1, 4]=>'red', [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
          [0, 5]=>nil, [1, 5]=>'yellow', [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
        }
        board_full_column.instance_variable_set(:@board_grid, board_with_full_col)
      end
      it 'returns true when column 2 is full' do
        column = '2'
        expect(board_full_column.column_full?(column)).to be(true)
      end
    end
  end

  describe '#connect_four?' do # rubocop: disable Metrics/BlockLength
    context 'when there is no connect four' do
      subject(:board_no_connect) { described_class.new }
      before do
        board_to_check = {
          [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
          [0, 1]=>'yellow', [1, 1]=>'red', [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
          [0, 2]=>nil, [1, 2]=>'red', [2, 2]=>'red', [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
          [0, 3]=>nil, [1, 3]=>'yellow', [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
          [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
          [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
        }
        board_no_connect.instance_variable_set(:@board_grid, board_to_check)
      end
      it "returns false when there's no connect four on the board for red" do
        color = 'red'
        expect(board_no_connect.connect_four?(color)).to be(false)
      end
    end

    context 'when a connect four is on the board' do # rubocop: disable Metrics/BlockLength
      context 'when the connect four is a column' do
        subject(:board_column_connect) { described_class.new }
        before do
          board_with_connect = {
            [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
            [0, 1]=>'yellow', [1, 1]=>'red', [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
            [0, 2]=>nil, [1, 2]=>'red', [2, 2]=>'red', [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
            [0, 3]=>nil, [1, 3]=>'red', [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
            [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
            [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
          }
          board_column_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of red discs in column 2" do
          color = 'red'
          expect(board_column_connect.connect_four?(color)).to be(true)
        end
      end

      context 'when the connect four is a row' do
        subject(:board_row_connect) { described_class.new }
        before do
          board_with_connect = {
            [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>'yellow', [5, 0]=>'yellow', [6, 0]=>'yellow',
            [0, 1]=>'yellow', [1, 1]=>'red', [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
            [0, 2]=>nil, [1, 2]=>'red', [2, 2]=>'red', [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
            [0, 3]=>nil, [1, 3]=>'red', [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
            [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
            [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
          }
          board_row_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of yellow discs on row 1" do
          color = 'yellow'
          expect(board_row_connect.connect_four?(color)).to be(true)
        end
      end

      context 'when the connect four is on a main diagonal' do
        subject(:board_main_connect) { described_class.new }
        before do
          board_with_connect = {
            [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
            [0, 1]=>'yellow', [1, 1]=>'red', [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
            [0, 2]=>nil, [1, 2]=>'red', [2, 2]=>'red', [3, 2]=>'yellow', [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
            [0, 3]=>nil, [1, 3]=>'yellow', [2, 3]=>nil, [3, 3]=>'red', [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
            [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
            [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
          }
          board_main_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of red discs on a main diagonal" do
          color = 'red'
          expect(board_main_connect.connect_four?(color)).to be(true)
        end
      end

      context 'when the connect four is on an anti-diagonal' do
        subject(:board_anti_connect) { described_class.new }
        before do
          board_with_connect = {
            [0, 0]=>'red', [1, 0]=>'red', [2, 0]=>'red', [3, 0]=>'yellow', [4, 0]=>nil, [5, 0]=>nil, [6, 0]=>nil,
            [0, 1]=>'yellow', [1, 1]=>'red', [2, 1]=>'yellow', [3, 1]=>'red', [4, 1]=>nil, [5, 1]=>nil, [6, 1]=>nil,
            [0, 2]=>'red', [1, 2]=>'yellow', [2, 2]=>'red', [3, 2]=>nil, [4, 2]=>nil, [5, 2]=>nil, [6, 2]=>nil,
            [0, 3]=>'yellow', [1, 3]=>'red', [2, 3]=>nil, [3, 3]=>nil, [4, 3]=>nil, [5, 3]=>nil, [6, 3]=>nil,
            [0, 4]=>nil, [1, 4]=>nil, [2, 4]=>nil, [3, 4]=>nil, [4, 4]=>nil, [5, 4]=>nil, [6, 4]=>nil,
            [0, 5]=>nil, [1, 5]=>nil, [2, 5]=>nil, [3, 5]=>nil, [4, 5]=>nil, [5, 5]=>nil, [6, 5]=>nil
          }
          board_anti_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of yellow discs on an anti-diagonal" do
          color = 'yellow'
          expect(board_anti_connect.connect_four?(color)).to be(true)
        end
      end
    end
  end
end

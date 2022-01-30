# frozen_string_lxiteral: true

require_relative '../lib/board'

describe Board do
  let(:red_disc) { '🔴' }
  let(:yellow_disc) { '🟡' }
  let(:partial_board) do
    [
      [red_disc, red_disc, red_disc, yellow_disc, nil, nil, nil],
      [yellow_disc, red_disc, yellow_disc, red_disc, nil, nil, nil],
      [nil, red_disc, red_disc, nil, nil, nil, nil],
      [nil, yellow_disc, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil]
    ]
  end

  describe '#place_disc' do
    subject(:board) { described_class.new }
    context 'when the column is empty' do
      context 'when the color is red' do
        it 'places a red disc in column 1 of the board' do
          column = '1'
          expected_x, expected_y = [0, 0]
          board.place_disc(red_disc, column)
          expect(board.board_grid[expected_y][expected_x]).to eq(red_disc)
        end

        it 'places a red disc in column 5 of the board' do
          column = '5'
          expected_x, expected_y = [4, 0]
          board.place_disc(red_disc, column)
          expect(board.board_grid[expected_y][expected_x]).to eq(red_disc)
        end
      end

      context 'when the color is yellow' do
        it 'places a yellow disc in column 3 of the board' do
          column = '3'
          expected_x, expected_y = [2, 0]
          board.place_disc(yellow_disc, column)
          expect(board.board_grid[expected_y][expected_x]).to eq(yellow_disc)
        end
      end
    end

    context 'when the first column is partially full' do
      before do
        board.instance_variable_set(:@board_grid, partial_board)
      end
      it 'places a red disc in column 1' do
        column = '1'
        expected_x, expected_y = [0, 2]
        board.place_disc(red_disc, column)
        expect(board.board_grid[expected_y][expected_x]).to eq(red_disc)
      end
    end

    context 'when the fourth column is partially full' do
      before do
        board.instance_variable_set(:@board_grid, partial_board)
      end
      it 'places a yellow disc in column 4' do
        column = '4'
        expected_x, expected_y = [3, 2]
        board.place_disc(yellow_disc, column)
        expect(board.board_grid[expected_y][expected_x]).to eq(yellow_disc)
      end
    end
  end

  describe '#column_full?' do
    context 'when none of the columns are full' do
      subject(:board_column_space) { described_class.new }
      before do
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
        board_with_full_col = [
          [red_disc, red_disc, red_disc, yellow_disc, nil, nil, nil],
          [yellow_disc, yellow_disc, yellow_disc, red_disc, nil, nil, nil],
          [nil, red_disc, red_disc, nil, nil, nil, nil],
          [nil, yellow_disc, nil, nil, nil, nil, nil],
          [nil, red_disc, nil, nil, nil, nil, nil],
          [nil, yellow_disc, nil, nil, nil, nil, nil]
        ]
        board_full_column.instance_variable_set(:@board_grid, board_with_full_col)
      end
      it 'returns true when column 2 is full' do
        column = '2'
        expect(board_full_column.column_full?(column)).to be(true)
      end
    end
  end

  describe '#connect_four?' do
    context 'when there is no connect four' do
      subject(:board_no_connect) { described_class.new }
      before do
        board_no_connect.instance_variable_set(:@board_grid, partial_board)
      end
      it "returns false when there's no connect four on the board for red" do
        expect(board_no_connect.connect_four?(red_disc)).to be(false)
      end
    end

    context 'when a connect four is on the board' do
      context 'when the connect four is a column' do
        subject(:board_column_connect) { described_class.new }
        before do
          board_with_connect = [
            [red_disc, red_disc, red_disc, yellow_disc, nil, nil, nil],
            [yellow_disc, red_disc, yellow_disc, red_disc, nil, nil, nil],
            [nil, red_disc, red_disc, nil, nil, nil, nil],
            [nil, red_disc, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil]
          ]
          board_column_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of red discs in column 2" do
          expect(board_column_connect.connect_four?(red_disc)).to be(true)
        end
      end

      context 'when the connect four is a row' do
        subject(:board_row_connect) { described_class.new }
        before do
          board_with_connect = [
            [red_disc, red_disc, red_disc, yellow_disc, yellow_disc, yellow_disc, yellow_disc],
            [yellow_disc, red_disc, yellow_disc, red_disc, nil, nil, nil],
            [nil, red_disc, red_disc, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil]
          ]
          board_row_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of yellow discs on row 1" do
          expect(board_row_connect.connect_four?(yellow_disc)).to be(true)
        end
      end

      context 'when the connect four is on an anti diagonal' do
        subject(:board_main_connect) { described_class.new }
        before do
          board_with_connect = [
            [red_disc, red_disc, red_disc, yellow_disc, nil, nil, nil],
            [yellow_disc, red_disc, yellow_disc, red_disc, nil, nil, nil],
            [nil, red_disc, red_disc, yellow_disc, nil, nil, nil],
            [nil, yellow_disc, nil, red_disc, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil]
          ]
          board_main_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of red discs on a main diagonal" do
          expect(board_main_connect.connect_four?(red_disc)).to be(true)
        end
      end

      context 'when the connect four is on a main diagonal' do
        subject(:board_anti_connect) { described_class.new }
        before do
          board_with_connect = [
            [red_disc, red_disc, red_disc, yellow_disc, nil, nil, nil],
            [yellow_disc, red_disc, yellow_disc, red_disc, nil, nil, nil],
            [red_disc, yellow_disc, red_disc, nil, nil, nil, nil],
            [yellow_disc, red_disc, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil]
          ]
          board_anti_connect.instance_variable_set(:@board_grid, board_with_connect)
        end
        it "returns true when there's a connect four of yellow discs on an anti-diagonal" do
          expect(board_anti_connect.connect_four?(yellow_disc)).to be(true)
        end
      end
    end
  end

  describe '#full_board?' do
    context 'when the board is not full' do
      subject(:non_full_board) { described_class.new }
      before do
        non_full_board.instance_variable_set(:@board_grid, partial_board)
      end
      it 'returns false' do
        expect(non_full_board.full_board?).to be(false)
      end
    end
    context 'when the board is full' do
      subject(:filled_board) { described_class.new }
      before do
        full_board = [
          [red_disc, red_disc, red_disc, red_disc, red_disc, red_disc, red_disc],
          [red_disc, red_disc, red_disc, red_disc, red_disc, red_disc, red_disc],
          [red_disc, red_disc, red_disc, red_disc, red_disc, red_disc, red_disc],
          [red_disc, red_disc, red_disc, red_disc, red_disc, red_disc, red_disc],
          [red_disc, red_disc, red_disc, red_disc, red_disc, red_disc, red_disc],
          [red_disc, red_disc, red_disc, red_disc, red_disc, red_disc, red_disc]
        ]
        filled_board.instance_variable_set(:@board_grid, full_board)
      end
      it 'returns true' do
        expect(filled_board.full_board?).to be(true)
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/game'

describe ConnectFour::Game do
  let(:player_one) { double(name: 'Player 1', disc: '🟡') }
  let(:player_two) { double(name: 'Player 2', disc: '🔴') }

  describe '#play_game' do
    let(:game_board) { double('game_board') }
    subject(:game) do
      described_class.new(
        player_one: player_one,
        player_two: player_two,
        game_board: game_board
      )
    end

    context 'when the user(s) plays one game of Connect Four' do
      before do
        allow(game).to receive(:puts)
        quit = 'n'
        allow(game).to receive_message_chain(:gets, :chomp).and_return(quit)
      end

      it 'calls game_loop one time' do
        expect(game).to receive(:game_loop).once
        game.play_game
      end
    end

    context 'when the user(s) play two games of Connect Four' do
      before do
        allow(game).to receive(:puts)
        play_again = 'y'
        quit = 'n'
        allow(game).to receive_message_chain(:gets, :chomp).and_return(play_again, quit)
      end

      it 'calls game_loop twice' do
        expect(game).to receive(:game_loop).twice
        game.play_game
      end
    end

    context 'when the user(s) play five games of Connect Four' do
      before do
        allow(game).to receive(:puts)
        play_again = 'y'
        quit = 'n'
        allow(game).to receive_message_chain(:gets, :chomp).and_return(play_again, play_again, play_again, play_again, quit)
      end

      it 'calls game_loop five times' do
        expect(game).to receive(:game_loop).exactly(5).times
        game.play_game
      end
    end
  end

  describe '#game_loop' do
    context 'when the game is over from connect four' do
      let(:game_board) { double(column_full?: false, full_board?: false, place_disc: nil) }
      subject(:connect_four_game) do
        described_class.new(
          player_one: player_one,
          player_two: player_two,
          game_board: game_board
        )
      end
      before do
        allow(game_board).to receive(:connect_four?).and_return(false, false, false, true)
        allow(connect_four_game).to receive(:puts)
        allow(connect_four_game).to receive_message_chain(:gets, :chomp).and_return('1')
      end

      it 'calls column_selection four times' do
        expect(connect_four_game).to receive(:column_selection).exactly(4).times
        connect_four_game.game_loop
      end
    end

    context 'when the game is over from a full board' do
      let(:game_board) { double(connect_four?: false, full_board?: false, place_disc: nil) }
      subject(:full_board_game) do
        described_class.new(
          player_one: player_one,
          player_two: player_two,
          game_board: game_board
        )
      end
      before do
        full_board_returns = Array.new(41, false) << true
        allow(game_board).to receive(:full_board?).and_return(*full_board_returns)
        allow(full_board_game).to receive(:puts)
        allow(full_board_game).to receive_message_chain(:gets, :chomp).and_return('1')
      end

      it 'calls column_selection forty-two times' do
        expect(full_board_game).to receive(:column_selection).exactly(42).times
        full_board_game.game_loop
      end
    end
  end

  describe '#play_again?' do
    let(:game_board) { double('game_board') }
    subject(:game) do
      described_class.new(
        player_one: player_one,
        player_two: player_two,
        game_board: game_board
      )
    end
    context 'when the user input is valid' do
      context "when the user input is 'y'" do
        before do
          allow(game).to receive(:puts)
          user_input = 'y'
          allow(game).to receive(:gets).and_return(user_input)
        end

        it 'returns true' do
          expect(game.play_again?).to be(true)
        end
      end

      context "when the user input is 'n'" do
        before do
          allow(game).to receive(:puts)
          user_input = 'n'
          allow(game).to receive(:gets).and_return(user_input)
        end

        it 'returns false' do
          expect(game.play_again?).to be(false)
        end
      end
    end

    context 'when the user input is invalid once' do
      before do
        allow(game).to receive(:puts)
        invalid_input = 'l'
        valid_input = 'y'
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it "returns true with valid 'y' input" do
        expect(game.play_again?).to be(true)
      end
    end
  end
end

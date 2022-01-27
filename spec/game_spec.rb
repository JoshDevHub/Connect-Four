# frozen_string_literal: true

require_relative '../lib/game'

describe ConnectFour::Game do # rubocop: disable Metrics/BlockLength
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
    # placeholder
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
  end
end

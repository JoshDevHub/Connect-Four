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
        # single_game.instance_variable_set(:@game_over, true)
        allow(game).to receive(:puts)
        allow(game).to receive(:play_again?).and_return(false)
      end
      it 'calls game_loop one time' do
        expect(game).to receive(:game_loop).once
        game.play_game
      end
    end
    context 'when the user(s) play two games of Connect Four' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:play_again?).and_return(true, false)
      end
      it 'calls game_loop twice' do
        expect(game).to receive(:game_loop).twice
        game.play_game
      end
    end
    context 'when the user(s) play five games of Connect Four' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:play_again?).and_return(true, true, true, true, false)
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
end

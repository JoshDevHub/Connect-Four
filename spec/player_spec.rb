# frozen_string_literal: true

describe Player do
  subject(:player) { described_class.new }
  describe '#user_selection' do
    context 'when user_selection is valid' do
      xit 'returns 5' do
        allow(player.take_input).to receive(:gets).and_return(5)
        expect(player.user_selection).to eq(5)
      end
    end
  end
end

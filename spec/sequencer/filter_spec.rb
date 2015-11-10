require_relative '../../sequencer/filter'

describe Sequencer::Filter do
  it 'accepts sequences that match a given block' do
    filter = Sequencer::Filter.new { |seq| seq.start_with?('b') }
    expect(filter.pick(['hai', 'buy', 'low', 'bit'])).to eq(['buy', 'bit'])
  end
end


require_relative '../../sequencer/normalizer'

describe Sequencer::Normalizer do
  it 'transforms a string based upon the supplied block' do
    normalizer = Sequencer::Normalizer.new { |str| str.strip.downcase }
    expect(normalizer.normalize("\tHello  WORlD   ")).to eq('hello  world')
  end
end


require_relative '../../sequencer/generator'

describe Sequencer::Generator do
  subject { Sequencer::Generator.new(4) }

  it 'generates sequences of a specified length' do
    gen_3 = Sequencer::Generator.new(3)
    gen_5 = Sequencer::Generator.new(5)
    gen_6 = Sequencer::Generator.new(6)

    expect(gen_3.sequences('hello')).to eq(['hel', 'ell', 'llo'])
    expect(gen_5.sequences('hello')).to eq(['hello'])
    expect(gen_6.sequences('hello')).to eq([])
  end
end

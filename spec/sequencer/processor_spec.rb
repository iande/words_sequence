require_relative '../../sequencer/processor'
require_relative '../../sequencer/generator'
require_relative '../../sequencer/filter'
require_relative '../../sequencer/normalizer'

describe Sequencer::Processor do
  let(:words) { ['arrows', 'carrots', 'give', 'me'] }

  it 'enumerates unique sequences from an array of words' do
    processor = Sequencer::Processor.new
    processor.generator = Sequencer::Generator.new(4)
    processor.normalizer = Sequencer::Normalizer.new { |s| s.strip.downcase }
    processor.filter = Sequencer::Filter.new { |seq| seq =~ /\A[a-z]+\z/ }
    
    expect(processor.process(words)).to eq({
      'carr' => 'carrots',
      'give' => 'give',
      'rots' => 'carrots',
      'rows' => 'arrows',
      'rrot' => 'carrots',
      'rrow' => 'arrows'
    })
  end

  it 'provides convenient getters for the sequences and words' do
    processor = Sequencer::Processor.new
    processor.generator = Sequencer::Generator.new(4)
    processor.normalizer = Sequencer::Normalizer.new { |s| s.strip.downcase }
    processor.filter = Sequencer::Filter.new { |seq| seq =~ /\A[a-z]+\z/ }
    processor.process(words)

    expect(processor.sequences).to eq(['rrow', 'rows', 'carr', 'rrot', 'rots',
                                       'give'])
    expect(processor.words).to eq(['arrows', 'arrows', 'carrots', 'carrots',
                                   'carrots', 'give'])
  end

  it 'preserves the original format of the input words' do
    processor = Sequencer::Processor.new
    processor.generator = Sequencer::Generator.new(4)
    processor.normalizer = Sequencer::Normalizer.new { |s| s.strip.downcase }
    processor.filter = Sequencer::Filter.new { |seq| seq =~ /\A[a-z]+\z/ }

    expect(processor.process(['Hello', 'woRld  '])).to eq({
      'hell' => 'Hello',
      'ello' => 'Hello',
      'worl' => 'woRld  ',
      'orld' => 'woRld  '
    })
  end

  it 'does not reject sequences that are repeated in a single word' do
    processor = Sequencer::Processor.new
    processor.generator = Sequencer::Generator.new(4)
    processor.normalizer = Sequencer::Normalizer.new { |s| s.strip.downcase }
    processor.filter = Sequencer::Filter.new { |seq| seq =~ /\A[a-z]+\z/ }

    # lifted this example straight outta dictionary.txt
    expect(processor.process(['alfalfa'])).to eq({
      "alfa" => 'alfalfa',
      'lfal' => 'alfalfa',
      'falf' => 'alfalfa'
    })
  end
end

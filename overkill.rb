require 'optparse'
require_relative './sequencer'


# Normalize sequence generators by removing leading and trailing whitespace
# and downcasing
normalizer = Sequencer::Normalizer.new { |s| s.strip.downcase }

# Generate sequences of 4 characters
generator = Sequencer::Generator.new(4)

# Only consider sequences that are made up of letters
filter = Sequencer::Filter.new { |seq| seq =~ /\A[a-z]+\z/ }

# Create and configure the processor
processor = Sequencer::Processor.new
processor.normalizer = normalizer
processor.generator = generator
processor.filter = filter

# Overkill, but who doesn't appreciate --help?
OptionParser.new do |opts|
  opts.banner = "Usage: ruby overkill.rb [dictionary file] [sequence file] [word file]"

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

dict_file = ARGV[0] || 'dictionary.txt'
seq_file = ARGV[1] || 'sequences'
word_file = ARGV[2] || 'words'

# Read the words from the dictionary file, one on each line
words = File.readlines(dict_file)
# Process the results
processor.process(words)

# Print the sequences to file
File.open(seq_file, "w") do |sf|
  processor.sequences.each do |sequence|
    sf.puts sequence
  end
end

# Print the words to file
File.open(word_file, "w") do |wf|
  processor.words.each do |word|
    wf.puts word
  end
end

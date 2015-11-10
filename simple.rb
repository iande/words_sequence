require 'set'

# Get the words from the dictionary file, one per line
words = File.readlines('./dictionary.txt')
candidates = { }

words.each do |word|
  # Remove trailing / leading spaces
  word = word.strip
  # Iterate over each consecutive 4 character substring (really a sub-array)
  word.chars.each_cons(4) do |seq_arr|
    # Convert the array to a string, and downcase
    sequence = seq_arr.join
    # Skip this sequence if it is not wholly composed of letters
    next unless sequence =~ /\A[A-Za-z]+\z/

    # Create a new Set for this sequence, if one doesn't exist
    candidates[sequence] ||= Set.new
    # Add this word to the set
    candidates[sequence] << word
  end
end

# Open 'sequences' for writing
File.open("./sequences", "w") do |seq_file|
  # Open 'words' for writing'
  File.open("./words", "w") do |word_file|
    # Iterate over all the candidates
    candidates.each do |sequence, words|
      # Skip this sequence if more than one word produced it
      next if words.length > 1

      # Write the sequence to file
      seq_file.puts sequence
      # Write the corresponding word to file
      word_file.puts words.first
    end
  end
end


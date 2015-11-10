require 'set'

words = File.readlines('./dictionary.txt')
candidates = { }

words.each do |word|
  word = word.strip
  word.chars.each_cons(4) do |seq_arr|
    sequence = seq_arr.join.downcase
    next unless sequence =~ /\A[a-z]+\z/
    candidates[sequence] ||= Set.new

    candidates[sequence] << word
  end
end

File.open("./sequences", "w") do |seq_file|
  File.open("./words", "w") do |word_file|
    candidates.each do |sequence, words|
      next if words.length > 1

      seq_file.puts sequence
      word_file.puts words.first
    end
  end
end


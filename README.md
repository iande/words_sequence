# Word Sequence Test Exercise

## The Problem

Given a list of words as input, create two output files: `sequences` and `words`.
The `sequences` file should contain every 4 letter (a-z) substring that appears in
one and only one word from the input list. Each entry in the `words` file should
be the word from the input that contains the corresponding 4 letter sequence in
the `sequences` file.

## Initial Thoughts/Concerns?

* Do we differentiate between upper and lower case letters?
* How do we handle non-letter characters (e.g., apostrophes, commas)? Do we
  simply reject substrings that contain them (e.g., "who's" has no candidate
  sequences because "who'" and "ho's" both contain an apostrophe) or do we
  omit the punctuation (e.g., "what're" yields "what", "hatr", and "atre".)
* Whitespace padding and input sanitation in general.

The basic idea could be represented as:

    words = File.readlines('./dictionary.txt')
    candidates = { }

    words.each do |word|
      word.chars.each_cons(4) do |seq_arr|
        sequence = seq_arr.join
        candidates[sequence] ||= []

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

This approach doesn't address the listed concerns and isn't very flexible, but
it illustrates the core of a solution. In the absence of explicit requirements
for our concerns, let's create a more flexible solution.

## Naive Solution

A solution based around the code above can be found in `naive_solution.rb`. It
assumes sequences are case-insensitive and rejects any sequence that contains
non-letter characters. It, hopefully, demonstrates that I can write a quick
script to do some one-off processing. Again, though, the code isn't very
flexible; moreover, it would be a pain to work this into any automated testing
system.

You can run the example with:

    ruby naive_approach.rb



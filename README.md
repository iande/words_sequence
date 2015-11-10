# Word Sequence Test Exercise

## The Problem

Given a list of words as input, create two output files: `sequences` and `words`.
The `sequences` file should contain every 4 letter (a-z) substring that appears in
one and only one word from the input list. Each entry in the `words` file should
be the word from the input that contains the corresponding 4 letter sequence in
the `sequences` file.

## Initial Thoughts/Concerns

* Do we differentiate between upper and lower case letters?
* How do we handle non-letter characters (e.g., apostrophes, commas)? Do we
  simply reject substrings that contain them (e.g., "who's" has no candidate
  sequences because "who'" and "ho's" both contain an apostrophe) or do we
  omit the punctuation (e.g., "what're" yields "what", "hatr", and "atre".)
* Whitespace padding and input sanitation in general.
* What about when the sequence is repeated within a word?

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

This approach doesn't address the listed concerns and buries the requirements
within the code -- for example, the requirement of 4 letter sequences. While
it does illustrate the core of a solution, we may want something that gives
us more flexibility and better separates configuration and implementation.

## Simple Solution

A solution based around the code above can be found in `simple.rb`. It
assumes sequences are case-insensitive and rejects any sequence that contains
non-letter characters. It, hopefully, demonstrates that I can write a quick
script to do some one-off processing. However, it would be a pain to work this
into any automated testing system.

You can run the example with:

    ruby simple.rb


## Overkill Solution

When I talk about embracing TDD/BDD in Ruby, I'm not just blowing smoke. Even
though it is almost certainly overkill for this exercise, I wanted to present
some code that's a little more indicative of what I'd do professionally.

You can run this example with:

    ruby overkill.rb [dictionary file] [sequence file] [word file]

You may also run the specs with:

    bundle exec rspec


## Final Thoughts

As stated above, if I were going to do some one-off text processing I would
probably put together a quick script such as the one found in `simple.rb`,
especially if the results didn't require complete accuracy. With the overkill
solution, I have created classes to demonstrate my testing practices, and
it's probably a bit much in case. I debated using a dedicated object to track
the counts and first word occurrence of the sequences instead of the simple
hash seen on line 38 of `sequencer/processor.rb`, but I felt that might be
a bit gratuitous and I wanted to wrap up both solutions in a single sitting.

If I needed to generalize this further, I would probably factor out the
reduction step (lines 21-24 of `sequencer/processor.rb`) and consider
supporting custom output handlers -- for example, alphabetizing the
sequence output (while preserving the associated words.)

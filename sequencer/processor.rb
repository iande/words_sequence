module Sequencer
  class Processor
    attr_accessor :generator, :normalizer, :filter

    def initialize
      @sequence_map = {}
    end

    # Processes an Array (or Enumerable) of words by normalizing each word,
    # generating the appropriately sized and filtered sequences. Once
    # processing is complete, a Hash mapping a sequence to its corresponding
    # unique word is returned
    def process words
      candidates = {} 
      words.each do |word|
        normalized_word = @normalizer.normalize(word)
        seqs = @generator.sequences(normalized_word)
        update_candidates(candidates, word, @filter.pick(seqs))
      end

      @sequence_map = candidates.inject({}) { |hsh, (k,v)|
        hsh[k] = v[:word] if v[:count] == 1
        hsh
      }
    end

    def sequences; @sequence_map.keys; end
    def words; @sequence_map.values; end

  private
    def update_candidates(candidates, word, picks)
      # In the naive solution, we used a Set, in this
      # case we associate a sequence with a hash that tracks the number
      # of words a sequence has appeared in as well as the first word it was
      # seen in. When all is said and done, we only keep the sequences whose
      # associated `count` is 1
      picks.each do |pick|
        candidates[pick] ||= { count: 1, word: word }
        prev_word = candidates[pick][:word]
        candidates[pick][:count] += 1 unless prev_word == word
      end
    end
  end
end

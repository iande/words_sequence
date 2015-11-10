module Sequencer
  class Filter
    def initialize(&blk)
      @selector = blk
    end

    def pick(sequences)
      sequences.select(&@selector)
    end
  end
end

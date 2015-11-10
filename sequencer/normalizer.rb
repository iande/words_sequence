module Sequencer
  class Normalizer 
    def initialize &blk
      @transform = blk
    end

    def normalize str
      @transform.call(str)
    end
  end
end

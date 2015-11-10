module Sequencer
  class Generator
    def initialize(seq_len)
      @sequence_length = seq_len
    end

    def sequences(str)
      str.chars.each_cons(@sequence_length).map { |s_arr| s_arr.join }
    end
  end
end

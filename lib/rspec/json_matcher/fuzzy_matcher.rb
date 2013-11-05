module RSpec
  module JsonMatcher
    class FuzzyMatcher < AbstractMatcher
      def compare
        FuzzyComparer.compare(parsed, expected)
      end
    end
  end
end

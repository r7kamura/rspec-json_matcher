module RSpec
  module JsonMatcher
    class FuzzyMatcher < AbstractMatcher
      def compare(&reason)
        FuzzyComparer.compare(parsed, expected, &reason)
      end
    end
  end
end

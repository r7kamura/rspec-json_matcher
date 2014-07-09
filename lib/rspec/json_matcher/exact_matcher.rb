module RSpec
  module JsonMatcher
    class ExactMatcher < AbstractMatcher
      def compare(&reason)
        ExactComparer.compare(parsed, expected, &reason)
      end
    end
  end
end

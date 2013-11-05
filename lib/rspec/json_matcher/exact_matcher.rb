module RSpec
  module JsonMatcher
    class ExactMatcher < AbstractMatcher
      def compare
        ExactComparer.compare(parsed, expected)
      end
    end
  end
end

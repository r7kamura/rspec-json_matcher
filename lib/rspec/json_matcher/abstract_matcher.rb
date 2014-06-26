module RSpec
  module JsonMatcher
    class AbstractMatcher
      attr_reader :expected, :parsed

      def initialize(expected = nil)
        @expected = expected
      end

      def matches?(json)
        @parsed = JSON.parse(json)
        if has_expectation?
          compare
        else
          true
        end
      rescue JSON::ParserError
        @parser_error = true
        false
      end

      def compare
        raise NotImplementedError, "You must implement #{self.class}#compare"
      end

      def description
        "be JSON"
      end

      def failure_message
        if has_parser_error?
          "expected value to be parsed as JSON, but failed"
        else
          inspection
        end
      end

      def negative_failure_message
        if has_parser_error?
          "expected value not to be parsed as JSON, but succeeded"
        else
          inspection("not ")
        end
      end
      alias :failure_message_when_negated :negative_failure_message

      private

      def has_parser_error?
        !!@parser_error
      end

      def has_expectation?
        !!expected
      end

      def inspection(prefix = nil)
        ["expected #{prefix}to match:", expected.ai(indent: -2), "", "actual:", parsed.ai(indent: -2)].join("\n")
      end
    end
  end
end

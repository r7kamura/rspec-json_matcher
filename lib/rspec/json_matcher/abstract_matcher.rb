module RSpec
  module JsonMatcher
    class AbstractMatcher
      attr_reader :expected, :parsed, :reasons

      def initialize(expected = nil)
        @expected = expected
        @reasons = []
      end

      def matches?(json)
        @parsed = JSON.parse(json)
        if has_expectation?
          compare do |reason|
            @reasons << reason
          end
        else
          true
        end
      rescue JSON::ParserError
        @parser_error = true
        false
      end

      alias_method :===, :matches?

      def compare(&reason)
        raise NotImplementedError, "You must implement #{self.class}#compare"
      end

      def description
        'be JSON'
      end

      def failure_message
        if has_parser_error?
          'expected value to be parsed as JSON, but failed'
        else
          inspection
        end
      end

      def negative_failure_message
        if has_parser_error?
          'expected value not to be parsed as JSON, but succeeded'
        else
          inspection('not ')
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
        messages = ["expected #{prefix}to match:", expected.ai(indent: -2), '', 'actual:', parsed.ai(indent: -2), '']
        messages.push "reason: #{reasons.reverse.join('.')}" unless reasons.empty?
        messages.join("\n")
      end
    end
  end
end

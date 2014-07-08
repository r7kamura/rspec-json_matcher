module RSpec
  module JsonMatcher
    class AbstractComparer
      attr_reader :actual, :expected, :reason

      def self.compare(*args, &reason)
        new(*args, &reason).compare
      end

      def self.extract_keys(array_or_hash)
        if array_or_hash.is_a?(Array)
          array_or_hash.each_index.to_a
        else
          array_or_hash.keys.map(&:to_s)
        end
      end

      def initialize(actual, expected, &reason)
        @actual   = actual
        @expected = expected
        @reason   = reason
      end

      def compare
        has_same_value? || has_same_collection?
      end

      private

      def has_same_class?
        actual.class == expected.class
      end

      def has_same_keys?
        actual_keys = self.class.extract_keys(actual).sort
        expected_keys = self.class.extract_keys(expected).sort
        (actual_keys == expected_keys).tap do |success|
          unless success
            diff_keys = (actual_keys - expected_keys) + (expected_keys - actual_keys)
            reason[diff_keys.ai]
          end
        end
      end

      def has_same_value?
        if expected.respond_to?(:call)
          expected.call(actual)
        else
          expected === actual
        end
      end

      def has_same_collection?
        raise NotImplementedError, "You must implement #{self.class}#has_same_collection?"
      end

      def has_same_values?
        if expected.is_a?(Array)
          expected.each_index.all? do |index|
            (index < actual.size && self.class.compare(actual[index], expected[index], &reason)).tap do |success|
              reason["[#{index}]"] unless success
            end
          end
        else
          expected.keys.all? do |key|
            (actual.has_key?(key.to_s) && self.class.compare(actual[key.to_s], expected[key], &reason)).tap do |success|
              reason[key.to_s] unless success
            end
          end
        end
      end

      def collection?
        actual.is_a?(Array) || actual.is_a?(Hash)
      end
    end
  end
end

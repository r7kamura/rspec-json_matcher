module RSpec
  module JsonMatcher
    class AbstractComparer
      attr_reader :actual, :expected

      def self.compare(*args)
        new(*args).compare
      end

      def self.extract_keys(array_or_hash)
        if array_or_hash.is_a?(Array)
          array_or_hash.each_index.to_a
        else
          array_or_hash.keys
        end
      end

      def initialize(actual, expected)
        @actual   = actual
        @expected = expected
      end

      def compare
        has_same_value? || has_same_collection?
      end

      private

      def has_same_class?
        actual.class == expected.class
      end

      def has_same_keys?
        self.class.extract_keys(actual).sort == self.class.extract_keys(expected).sort
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
            index < actual.size && self.class.compare(actual[index], expected[index])
          end
        else
          expected.keys.all? do |key|
            actual.has_key?(key) && self.class.compare(actual[key], expected[key])
          end
        end
      end

      def collection?
        actual.is_a?(Array) || actual.is_a?(Hash)
      end
    end
  end
end

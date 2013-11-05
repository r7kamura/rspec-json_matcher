module RSpec
  module JsonMatcher
    class ExactComparer < AbstractComparer
      private

      def has_same_collection?
        collection? && has_same_class? && has_same_keys? && has_same_values?
      end
    end
  end
end

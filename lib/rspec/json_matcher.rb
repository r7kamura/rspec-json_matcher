require "rspec/json_matcher/version"
require "rspec/json_matcher/abstract_comparer"
require "rspec/json_matcher/exact_comparer"
require "rspec/json_matcher/fuzzy_comparer"
require "rspec/json_matcher/abstract_matcher"
require "rspec/json_matcher/exact_matcher"
require "rspec/json_matcher/fuzzy_matcher"
require "json"
require "amazing_print"

module RSpec
  module JsonMatcher
    def be_json(expected = nil)
      ExactMatcher.new(expected)
    end

    def be_json_as(expected)
      ExactMatcher.new(expected)
    end

    def be_json_including(expected)
      FuzzyMatcher.new(expected)
    end
  end
end

# RSpec::JsonMatcher

[![test](https://github.com/r7kamura/rspec-json_matcher/actions/workflows/test.yml/badge.svg)](https://github.com/r7kamura/rspec-json_matcher/actions/workflows/test.yml)

This library provides RSpec matcher for testing JSON string.

* parsing a given value as JSON string
* handy pattern matching with `#===` method like case-when statement
* supporting nested pattern matching

## Installation

Install RSpec::JsonMatcher:
```shell
$ gem install rspec-json_matcher
```
Or add it to your Gemfile:
```ruby
gem 'rspec-json_matcher'
```

## Usage
### Configuration
```ruby
# spec/spec_helper.rb
require "rspec/json_matcher"
RSpec.configuration.include RSpec::JsonMatcher
```

### Matchers
* be_json
* be_json_including
* be_json_as

```ruby
{ "a" => "b", "c" => "d" }.to_json.should be_json
{ "a" => "b", "c" => "d" }.to_json.should be_json_including("a" => "b")
{ "a" => "b", "c" => "d" }.to_json.should be_json_as("a" => "b", "c" => "d")
```

### Example
```ruby
[
  {
    "url" => "https://api.github.com/gists/17a07d0a27fd3f708f5f",
    "id" => "1",
    "description" => "description of gist",
    "public" => true,
    "user" => {
      "login" => "octocat",
      "id" => 1,
      "avatar_url" => "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id" => "somehexcode",
      "url" => "https://api.github.com/users/octocat"
    },
    "files" => {
      "ring.erl" => {
        "size" => 932,
        "filename" => "ring.erl",
        "raw_url" => "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
      }
    },
    "comments" => 0,
    "comments_url" => "https://api.github.com/gists/6fb6af8cb6e26dbbc327/comments/",
    "html_url" => "https://gist.github.com/1",
    "git_pull_url" => "git://gist.github.com/1.git",
    "git_push_url" => "git@gist.github.com:1.git",
    "created_at" => "2010-04-14T02:15:15Z"
  }
].to_json.should be_json_as([
  {
    "url"          => /^https:/,
    "id"           => /^\d+$/,
    "description"  => /gist/,
    "public"       => true,
    "user"         => Hash,
    "files"        => Hash,
    "comments"     => Fixnum,
    "comments_url" => /^https:/,
    "html_url"     => /^https:/,
    "git_pull_url" => /^git:/,
    "git_push_url" => /^git@/,
    "created_at"   => /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\dZ/,
  }
])
```

### Failure message
![](http://dl.dropbox.com/u/5978869/image/20130426_005849.png)

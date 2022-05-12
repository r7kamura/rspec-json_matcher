require 'spec_helper'

describe RSpec::JsonMatcher do
  describe '#be_json' do
    context 'with invalid JSON' do
      it 'does not match' do
        ''.should_not be_json
      end
    end

    context 'with valid JSON' do
      it 'matches' do
        {}.to_json.should be_json
      end
    end

    context 'when used with a composable matcher' do
      it 'matches' do
        {
          'a' => {'b' => 1}.to_json
        }.should match('a' => be_json)
      end
    end
  end

  describe '#be_json_as' do
    context 'with invalid JSON' do
      it 'does not match' do
        ''.should_not be_json_as('a' => 'b')
      end
    end

    context 'with few keys' do
      it 'does not match' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should_not be_json_as(
          'a' => 1,
        )
      end
    end

    context 'with too many keys' do
      it 'does not match' do
        {
          'a' => 1,
        }.to_json.should_not be_json_as(
          'a' => 1,
          'b' => 2,
        )
      end
    end

    context 'with different values' do
      it 'does not match' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should_not be_json_as(
          'a' => 2,
          'b' => 2,
        )
      end
    end

    context 'with same keys and values' do
      it 'matches' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should be_json_as(
          'a' => 1,
          'b' => 2,
        )
      end
    end

    context 'with nil values' do
      it 'does not match' do
        {
          'a' => nil,
        }.to_json.should_not be_json_as(
          'b' => nil,
        )
      end
    end

    context 'with subset array' do
      it 'does not match' do
        [
          'a',
          'b',
        ].to_json.should_not be_json_as(
          [
            'a',
          ],
        )
      end
    end

    context 'with superset array' do
      it 'does not match' do
        [
          'a',
          'b',
        ].to_json.should_not be_json_as(
          [
            'a',
            'b',
            'c',
          ],
        )
      end
    end

    context 'with superset array with nil' do
      it 'does not match' do
        [
          'a',
          'b',
        ].to_json.should_not be_json_as(
          [
            'a',
            'b',
            nil,
          ],
        )
      end
    end

    context 'with complex JSON' do
      it 'matches' do
        [
          {
            'url' => 'https://api.github.com/gists/17a07d0a27fd3f708f5f',
            'id' => '1',
            'description' => 'description of gist',
            'public' => true,
            'user' => {
              'login' => 'octocat',
              'id' => 1,
              'avatar_url' => 'https://github.com/images/error/octocat_happy.gif',
              'gravatar_id' => 'somehexcode',
              'url' => 'https://api.github.com/users/octocat'
            },
            'files' => {
              'ring.erl' => {
                'size' => 932,
                'filename' => 'ring.erl',
                'raw_url' => 'https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl'
              }
            },
            'comments' => 0,
            'comments_url' => 'https://api.github.com/gists/6fb6af8cb6e26dbbc327/comments/',
            'html_url' => 'https://gist.github.com/1',
            'git_pull_url' => 'git://gist.github.com/1.git',
            'git_push_url' => 'git@gist.github.com:1.git',
            'created_at' => '2010-04-14T02:15:15Z'
          }
        ].to_json.should be_json_as([
          {
            'url'          => /^https:/,
            'id'           => /^\d+$/,
            'description'  => /gist/,
            'public'       => true,
            'user'         => Hash,
            'files'        => Hash,
            'comments'     => Fixnum,
            'comments_url' => /^https:/,
            'html_url'     => /^https:/,
            'git_pull_url' => /^git:/,
            'git_push_url' => /^git@/,
            'created_at'   => /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\dZ/,
          }
        ])
      end
    end

    context 'with symbol keys expectation' do
      it 'matches' do
        { 'foo' => 'bar' }.to_json.should be_json_as(foo: 'bar')
      end
    end

    context 'when used with a composable matcher' do
      it 'matches' do
        {
          'a' => {'b' => 1}.to_json
        }.should match('a' => be_json_as('b' => 1))
      end
    end
  end

  describe '#be_json_including' do
    context 'with invalid JSON' do
      it 'does not match' do
        ''.should_not be_json_including('a' => 'b')
      end
    end

    context 'with few keys' do
      it 'matches' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should be_json_including(
          'a' => 1,
        )
      end
    end

    context 'with too many keys' do
      it 'matches' do
        {
          'a' => 1,
        }.to_json.should_not be_json_including(
          'a' => 1,
          'b' => 2,
        )
      end
    end

    context 'with different values' do
      it 'does not match' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should_not be_json_including(
          'a' => 2,
          'b' => 2,
        )
      end
    end

    context 'with partially different set' do
      it 'does not match' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should_not be_json_including(
          'a' => 0,
          'b' => 2,
        )
      end
    end

    context 'with same keys and values' do
      it 'matches' do
        {
          'a' => 1,
          'b' => 2,
        }.to_json.should be_json_including(
          'a' => 1,
          'b' => 2,
        )
      end
    end

    context 'with nil values' do
      it 'does not match' do
        {
          'a' => nil,
        }.to_json.should_not be_json_including(
          'b' => nil,
        )
      end
    end

    context 'with subset array' do
      it 'does not match' do
        [
          'a',
          'b',
        ].to_json.should be_json_including(
          [
            'a',
          ],
        )
      end
    end

    context 'with superset array' do
      it 'does not match' do
        [
          'a',
          'b',
        ].to_json.should_not be_json_including(
          [
            'a',
            'b',
            'c',
          ],
        )
      end
    end

    context 'with superset array with nil' do
      it 'does not match' do
        [
          'a',
          'b',
        ].to_json.should_not be_json_including(
          [
            'a',
            'b',
            nil,
          ],
        )
      end
    end

    context 'when used with a composable matcher' do
      it 'matches' do
        {
          'a' => {'b' => 1, 'c' => 2}.to_json
        }.should match('a' => be_json_including('b' => 1))
      end
    end
  end
end

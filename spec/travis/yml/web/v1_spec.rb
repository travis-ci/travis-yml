require 'spec_helper'

describe Travis::Yml::Web::V1 do
  include Rack::Test::Methods

  let(:status)  { last_response.status }
  let(:headers) { last_response.headers }
  let(:body)    { Oj.load(last_response.body) }
  let(:app)     { described_class }
  let(:params)  { { } }

  describe 'GET /' do
    it 'is ok' do
      get '/'
      expect(status).to eq 200
    end

    it 'is html' do
      get '/'
      expect(headers['Content-Type']).to eq 'text/html'
    end
  end

  describe 'POST /parse' do
    it 'is ok' do
      post '/parse', 'rvm: 2.3', {}
      expect(status).to eq 200
    end

    it 'is json' do
      post '/parse', 'rvm: 2.3', {}
      expect(headers['Content-Type']).to eq 'application/json'
    end

    it 'returns version' do
      post '/parse', 'rvm: 2.3', {}
      expect(body['version']).to eq 'v1'
    end

    it 'returns parsed config' do
      post '/parse', 'rvm: 2.3', {}
      expect(body['config']).to include('rvm' => ['2.3'])
    end

    it 'returns structured message attrs' do
      post '/parse?defaults=true', 'rvm: 2.3', {}
      expect(body['messages']).to include(
        'type' => 'config',
        'level' => 'info',
        'key' => 'language',
        'code' => 'default',
        'args' => { 'key' => 'language', 'default' => 'ruby' },
      )
      expect(body['messages']).to include(
        'type' => 'config',
        'level' => 'info',
        'key' => 'os',
        'code' => 'default',
        'args' => { 'key' => 'os', 'default' => 'linux' },
      )
    end

    it 'returns full messages' do
      post '/parse?defaults=true', 'rvm: 2.3', {}
      expect(body['full_messages']).to include(
        '[info] on language: missing language, using the default "ruby"'
      )
      expect(body['full_messages']).to include(
        '[info] on os: missing os, using the default "linux"'
      )
    end

    it 'sorts messages by severity' do
      post '/parse?defaults=true', "rvm: 2.3\nbutt: true", {}
      expect(body['messages'].map { |m| m['level'] }).to eq [
        'warn',
        'info',
        'info',
      ]
    end

    context 'input error' do
      before do
        post '/parse', 'hello', {}
      end

      it 'is bad request' do
        expect(status).to eq 400
      end

      it 'returns error' do
        expect(body['error_type']).to eq 'unexpected_config_format'
        expect(body['error_message']).to eq 'Input must be a hash'
      end
    end

    context 'psych error' do
      before do
        post '/parse', '********', {}
      end

      it 'is bad request' do
        expect(status).to eq 400
      end

      it 'returns syntax error' do
        expect(body['error_type']).to eq 'syntax_error'
        expect(body['error_message']).to match 'did not find expected alphabetic or numeric character while scanning an alias'
      end
    end

    context 'internal error' do
      before do
        allow(Travis::Yml).to receive(:load).and_raise(Travis::Yml::StackTooHigh, 'Stack size 100000')
        post '/parse', 'rvm: 2.3', {}
      end

      it 'is internal server error' do
        expect(status).to eq 500
      end

      it 'returns error' do
        expect(body['error_type']).to eq 'stack_too_high'
        expect(body['error_message']).to eq 'Stack size 100000'
      end
    end
  end

  describe 'POST /parse (multipart)' do
    let(:headers) { { 'CONTENT_TYPE' => 'application/vnd.travis-ci.configs+json' } }

    let(:api) do
      <<~yml
        rvm: 2.6.2
        env:
          API: true
          FOO: 1
        unknown: str
      yml
    end

    let(:travis_yml) do
      <<~yml
        rvm: 2.2.2
        env:
          TRAVIS_YML: true
          FOO: 2
        script: !seq+append
          - ./travis_yml
      yml
    end

    let(:import) do
      <<~yml
        language: ruby
        env:
          IMPORT: true
          FOO: 3
        script:
          - ./import
      yml
    end

    let(:data) do
      [
        { 'config' => api,        'source' => 'api',         'merge_mode' => nil },
        { 'config' => travis_yml, 'source' => '.travis.yml', 'merge_mode' => mode },
        { 'config' => import,     'source' => 'import.yml',  'merge_mode' => mode },
      ]
    end

    before { post '/parse?line=true', Oj.dump(data), headers }

    describe 'merge_mode: merge' do
      let(:mode) { 'merge' }

      it { expect(status).to eq 200 }

      it do
        expect(body['config']).to eq(
          'language' => 'ruby',
          'rvm' => [
            '2.6.2'
          ],
          'env' => {
            'matrix' => [
              'API' => 'true',
              'FOO' => '1'
            ]
          },
          'script' => [
            './travis_yml'
          ],
          'unknown' => 'str'
        )
      end

      it do
        expect(body['messages']).to include(
          'type' => 'config',
          'level' => 'warn',
          'code' => 'unknown_key',
          'key' => 'root',
          'args' => {
            'key' => 'unknown',
            'value' => 'str',
          },
          'src' => 'api',
          'line' => 4,
        )
      end

      it do
        expect(body['full_messages']).to include(
          '[warn] on root: unknown key "unknown" (str)'
        )
      end
    end

    describe 'merge_mode: deep_merge' do
      let(:mode) { 'deep_merge' }

      it { expect(status).to eq 200 }

      it do
        expect(body['config']).to eq(
          'language' => 'ruby',
          'rvm' => [
            '2.6.2'
          ],
          'env' => {
            'matrix' => [
              'API' => 'true',
              'FOO' => '1',
              'TRAVIS_YML' => 'true',
              'IMPORT' => 'true'
            ]
          },
          'script' => [
            './import',
            './travis_yml'
          ],
          'unknown' => 'str'
        )
      end

    end
  end

  describe 'POST /expand' do
    it 'is ok' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(status).to eq 200
    end

    it 'is json' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(headers['Content-Type']).to eq 'application/json'
    end

    it 'returns version' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(body['version']).to eq 'v1'
    end

    it 'returns expanded matrix' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(body['matrix']).to eq [{ 'rvm' => '2.3' }]
    end

    context 'input error' do
      before do
        post '/expand', '', {}
      end

      it 'is bad request' do
        expect(status).to eq 400
      end

      it 'returns error' do
        expect(body['error_type']).to eq 'encoding_error'
        expect(body['error_message']).to match /Empty input.*at line 1, column 1/
      end
    end
  end
end

require 'spec_helper'

describe Travis::Yaml::Web::V1 do
  include Rack::Test::Methods

  def app
    described_class
  end

  def response
    Oj.load(last_response.body)
  end

  describe 'GET /' do
    it 'is ok' do
      get '/'
      expect(last_response.status).to eq 200
    end

    it 'is json' do
      get '/'
      expect(last_response.headers['Content-Type']).to eq 'application/json'
    end

    it 'returns version' do
      get '/'
      expect(response['version']).to eq 'v1'
    end
  end

  describe 'POST /parse' do
    it 'is ok' do
      post '/parse', 'rvm: 2.3', {}
      expect(last_response.status).to eq 200
    end

    it 'is json' do
      post '/parse', 'rvm: 2.3', {}
      expect(last_response.headers['Content-Type']).to eq 'application/json'
    end

    it 'returns version' do
      post '/parse', 'rvm: 2.3', {}
      expect(response['version']).to eq 'v1'
    end

    it 'returns parsed config' do
      post '/parse', 'rvm: 2.3', {}
      expect(response['config']).to include('rvm' => ['2.3'])
    end

    it 'returns structured message attrs' do
      post '/parse', 'rvm: 2.3', {}
      expect(response['messages']).to eq [
        {
          'level' => 'info',
          'key' => 'language',
          'code' => 'default',
          'args' => { 'key' => 'language', 'default' => 'ruby' }
        }
      ]
    end

    it 'sorts messages by severity' do
      post '/parse', "rvm: 2.3\nbutt: true", {}
      expect(response['messages'].map { |m| m['level'] }).to eq [
        'error',
        'info'
      ]
    end

    it 'returns full messages' do
      post '/parse', 'rvm: 2.3', {}
      expect(response['full_messages']).to eq [
        '[info] on language: missing :language, using the default ruby'
      ]
    end

    context 'input error' do
      before do
        post '/parse', 'hello', {}
      end

      it 'is bad request' do
        expect(last_response.status).to eq 400
      end

      it 'returns error' do
        expect(response['error_type']).to eq 'unexpected_config_format'
        expect(response['error_message']).to eq 'Input must be a hash'
      end
    end

    context 'psych error' do
      before do
        post '/parse', '********', {}
      end

      it 'is bad request' do
        expect(last_response.status).to eq 400
      end

      it 'returns syntax error' do
        expect(response['error_type']).to eq 'syntax_error'
        expect(response['error_message']).to match 'did not find expected alphabetic or numeric character while scanning an alias'
      end
    end

    context 'internal error' do
      before do
        allow(Travis::Yaml).to receive(:load).and_raise(Travis::Yaml::StackTooHigh, 'Stack size 100000')
        post '/parse', 'rvm: 2.3', {}
      end

      it 'is internal server error' do
        expect(last_response.status).to eq 500
      end

      it 'returns error' do
        expect(response['error_type']).to eq 'stack_too_high'
        expect(response['error_message']).to eq 'Stack size 100000'
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
      yml
    end

    let(:travis_yml) do
      <<~yml
        rvm: 2.2.2
        script: ./script
        env:
          TRAVIS_YML: true
          FOO: 2
      yml
    end

    let(:import) do
      <<~yml
        language: ruby
        env:
          IMPORT: true
          FOO: 3
      yml
    end

    let(:data) do
      [
        { 'config' => api,        'source' => 'api',         'merge_mode' => nil },
        { 'config' => travis_yml, 'source' => '.travis.yml', 'merge_mode' => mode },
        { 'config' => import,     'source' => 'import.yml',  'merge_mode' => mode },
      ]
    end

    before { post '/parse', Oj.dump(data), headers }

    describe 'merge_mode: merge' do
      let(:mode) { 'merge' }

      it { expect(last_response.status).to eq 200 }
      it { expect(response['config']['language']).to eq 'ruby' }
      it { expect(response['config']['rvm']).to eq ['2.6.2'] }
      it { expect(response['config']['script']).to eq ['./script'] }
      it { expect(response['config']['env']['matrix']).to eq ['API=true', 'FOO=1'] }
    end

    describe 'merge_mode: deep_merge' do
      let(:mode) { 'deep_merge' }

      it { expect(last_response.status).to eq 200 }
      it { expect(response['config']['language']).to eq 'ruby' }
      it { expect(response['config']['rvm']).to eq ['2.6.2'] }
      it { expect(response['config']['script']).to eq ['./script'] }
      it { expect(response['config']['env']['matrix']).to eq ['IMPORT=true', 'FOO=1', 'TRAVIS_YML=true', 'API=true'] }
    end
  end

  describe 'POST /expand' do
    it 'is ok' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(last_response.status).to eq 200
    end

    it 'is json' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(last_response.headers['Content-Type']).to eq 'application/json'
    end

    it 'returns version' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(response['version']).to eq 'v1'
    end

    it 'returns expanded matrix' do
      post '/expand', '{"rvm":"2.3"}', {}
      expect(response['matrix']).to eq [{ 'rvm' => '2.3' }]
    end

    context 'input error' do
      before do
        post '/expand', '', {}
      end

      it 'is bad request' do
        expect(last_response.status).to eq 400
      end

      it 'returns error' do
        expect(response['error_type']).to eq 'encoding_error'
        expect(response['error_message']).to match /Empty input.*at line 1, column 1/
      end
    end
  end
end

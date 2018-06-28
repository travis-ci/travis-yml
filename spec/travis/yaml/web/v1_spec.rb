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
          expect(response['error_message']).to match 'Empty input at line 1, column 1'
        end
      end
    end
  end
end

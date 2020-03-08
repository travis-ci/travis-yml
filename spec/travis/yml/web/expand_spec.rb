require 'spec_helper'

describe Travis::Yml::Web::App, 'POST /expand' do
  include Rack::Test::Methods

  let(:app)     { described_class }
  let(:status)  { last_response.status }
  let(:headers) { last_response.headers }
  let(:body)    { Oj.load(last_response.body) }
  let(:params)  { {} }

  it 'is ok' do
    post '/expand', '{ "config": { "rvm" : "2.3" } }', {}
    expect(status).to eq 200
  end

  it 'is json' do
    post '/expand', '{ "config": { "rvm" : "2.3" } }', {}
    expect(headers['Content-Type']).to eq 'application/json'
  end

  it 'returns expanded matrix' do
    post '/expand', '{ "config": { "rvm" : "2.3" } }', {}
    expect(body['matrix']).to eq [{ 'rvm' => '2.3' }]
  end

  describe 'input error' do
    before do
      post '/expand', '', {}
    end

    it 'is bad request' do
      expect(status).to eq 400
    end

    it 'returns error' do
      expect(body['error']['type']).to eq 'encoding_error'
      expect(body['error']['message']).to match /Empty input.*at line 1, column 1/
    end
  end
end

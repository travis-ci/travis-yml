require 'spec_helper'

describe Travis::Yml::Web::App, '/' do
  include Rack::Test::Methods

  let(:status)  { last_response.status }
  let(:headers) { last_response.headers }
  let(:body)    { Oj.load(last_response.body) }
  let(:app)     { described_class }
  let(:params)  { { } }

  before { get '/' }

  it { expect(status).to eq 200 }
  it { expect(headers['Content-Type']).to eq 'text/html;charset=utf-8' }
end

require 'spec_helper'

describe Travis::Yml::Web::App, 'POST /configs' do
  include Rack::Test::Methods

  let(:app)     { described_class }
  let(:status)  { last_response.status }
  let(:headers) { last_response.headers }
  let(:body)    { Oj.load(last_response.body, symbol_keys: true) }
  let(:data)    { { repo: repo, type: type, ref: ref, mode: 'deep_merge_prepend' } }
  let(:repo)    { { slug: 'travis-ci/travis-yml', token: 'token', private: false, private_key: 'key', allow_config_imports: true } }
  let(:type)    { :push }
  let(:ref)     { 'ref' }

  let(:travis_yml) { 'import: one.yml' }
  let(:one_yml)    { 'script: ./one' }

  before { stub_content(repo[:slug], '.travis.yml', travis_yml) }
  before { stub_content(repo[:slug], 'one.yml', one_yml) }
  before { post '/configs', Oj.generate(data), defaults: true }

  it { expect(status).to eq 200 }
  it { expect(headers['Content-Type']).to eq 'application/json' }

  it do
    expect(body[:raw_configs]).to eq [
      {
        source: 'travis-ci/travis-yml:.travis.yml@ref',
        config: travis_yml,
        mode: 'deep_merge_prepend'
      },
      {
        source: 'travis-ci/travis-yml:one.yml@ref',
        config: one_yml,
        mode: nil
      }
    ]
  end

  it do
    expect(body[:config]).to eq(
      script: ['./one']
    )
  end

  it do
    expect(body[:matrix]).to eq [
      script: ['./one']
    ]
  end

  # describe 'error handling' do
  #   before do
  #     post '/expand', '', {}
  #   end
  #
  #   it 'is bad request' do
  #     expect(status).to eq 400
  #   end
  #
  #   it 'returns error' do
  #     expect(body['error_type']).to eq 'encoding_error'
  #     expect(body['error_message']).to match /Empty input.*at line 1, column 1/
  #   end
  # end
end

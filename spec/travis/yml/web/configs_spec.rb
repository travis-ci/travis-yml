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

  context do
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
        import: [source: 'one.yml'],
        script: ['./one']
      )
    end

    it do
      expect(body[:matrix]).to eq [
        script: ['./one']
      ]
    end

    describe 'api' do
      let(:config) { JSON.dump(merge_mode: 'merge') }
      let(:data) { { repo: repo, type: type, ref: ref, config: config } }
      let(:travis_yml) { 'import: { source: one.yml, mode: deep_merge_prepend }' }

      it do
        expect(body[:raw_configs]).to eq [
          {
            source: 'api',
            config: config,
            mode: 'merge'
          },
          {
            source: 'travis-ci/travis-yml:.travis.yml@ref',
            config: travis_yml,
            mode: 'merge'
          },
          {
            source: 'travis-ci/travis-yml:one.yml@ref',
            config: one_yml,
            mode: 'deep_merge_prepend'
          }
        ]
      end
    end
  end

  describe 'travis api errors' do
    let(:travis_yml) { 'import: other/other:one.yml' }

    before { stub_content('other/other', 'one.yml', one_yml) }
    before { stub_repo('other/other', internal: true, status: status) }
    subject { post '/configs', Oj.generate(data), defaults: true }

    context do
      before { subject }

      describe '401' do
        let(:status) { 401 }
        it { expect(status).to eq status }
      end

      describe '403' do
        let(:status) { 403 }
        it { expect(status).to eq status }
      end

      describe '404' do
        let(:status) { 404 }
        it { expect(status).to eq status }
      end
    end

    describe '500' do
      let(:status) { 500 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
    end
  end
end

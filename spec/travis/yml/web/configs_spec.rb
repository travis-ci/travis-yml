require 'spec_helper'

describe Travis::Yml::Web::App, 'POST /configs' do
  include Rack::Test::Methods

  let(:app)     { described_class }
  let(:status)  { last_response.status }
  let(:headers) { last_response.headers }
  let(:body)    { Oj.load(last_response.body, symbol_keys: true) }
  let(:data)    { { repo: repo, type: type, ref: ref, mode: 'deep_merge_prepend' } }
  let(:repo)    { { github_id: 1, slug: 'travis-ci/travis-yml', token: 'token', private: false, private_key: 'key', allow_config_imports: true } }
  let(:type)    { :push }
  let(:ref)     { 'ref' }

  let(:travis_yml) { 'import: one.yml' }
  let(:one_yml)    { 'script: ./one' }

  before { stub_content(repo[:github_id], '.travis.yml', travis_yml) }
  before { stub_content(repo[:github_id], 'one.yml', one_yml) }
  before { header 'Authorization', 'internal token' }

  context do
    before { post '/configs', Oj.generate(data) }

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

  describe 'errors' do
    let(:body) { symbolize(JSON.parse(last_response.body)) }
    before { post '/configs', Oj.generate(data), defaults: true }

    describe 'syntax error' do
      let(:travis_yml) { '{' }
      it { expect(last_response.status).to eq 400 }
      it do
        expect(body).to eq(
          error: {
            type: 'syntax_error',
            source: 'travis-ci/travis-yml:.travis.yml@ref',
            message: '(<unknown>): did not find expected node content while parsing a flow node at line 2 column 1 (source: travis-ci/travis-yml:.travis.yml@ref)'
          }
        )
      end
    end

    describe 'invalid config format' do
      let(:travis_yml) { 'str' }
      it { expect(last_response.status).to eq 400 }
      it do
        expect(body).to eq(
          error: {
            type: 'invalid_config_format',
            source: 'travis-ci/travis-yml:.travis.yml@ref',
            message: 'Input must parse into a hash (source: travis-ci/travis-yml:.travis.yml@ref)'
          }
        )
      end
    end
  end

  describe 'travis api errors' do
    let(:travis_yml) { 'import: other/other:one.yml' }
    let(:body) { symbolize(JSON.parse(last_response.body)) }

    before { stub_content('other/other', 'one.yml', one_yml) }
    before { stub_repo('other/other', internal: true, status: status) }
    subject { post '/configs', Oj.generate(data), defaults: true }

    context do
      before { subject }

      describe '401' do
        let(:status) { 401 }
        it { expect(last_response.status).to eq 400 }
        it do
          expect(body).to eq(
            error: {
              type: 'unauthorized',
              service: 'travis_ci',
              ref: 'other/other',
              message: 'Unable to authenticate with Travis CI for repo other/other (Travis CI GET repo/other%2Fother responded with 401)'
            }
          )
        end
      end

      describe '403' do
        let(:status) { 403 }
        it { expect(last_response.status).to eq 400 }
        it do
          expect(body).to eq(
            error: {
              type: 'unauthorized',
              service: 'travis_ci',
              ref: 'other/other',
              message: 'Unable to authenticate with Travis CI for repo other/other (Travis CI GET repo/other%2Fother responded with 403)'
            }
          )
        end
      end

      describe '404' do
        let(:status) { 404 }
        it { expect(last_response.status).to eq 400 }
        it do
          expect(body).to eq(
            error: {
              type: 'repo_not_found',
              service: 'travis_ci',
              ref: 'other/other',
              message: 'Repo other/other not found on Travis CI (Travis CI GET repo/other%2Fother responded with 404)'
            }
          )
        end
      end
    end

    describe '500' do
      let(:status) { 500 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
    end
  end

  describe 'github api errors' do
    let(:travis_yml) { 'import: other/other:one.yml' }
    let(:body) { symbolize(JSON.parse(last_response.body)) }

    before { stub_repo('other/other', internal: true, body: { github_id: 1 }) }
    before { stub_content(1, 'one.yml', status: status) }
    subject { post '/configs', Oj.generate(data), defaults: true }

    context do
      before { subject }

      describe '401' do
        let(:status) { 401 }
        it { expect(last_response.status).to eq 400 }
        it do
          expect(body).to eq(
            error: {
              type: 'unauthorized',
              service: 'github',
              ref: 'other/other:one.yml',
              message: 'Unable to authenticate with GitHub for file other/other:one.yml (GitHub GET repositories/1/contents/one.yml responded with 401)'
            }
          )
        end
      end

      describe '403' do
        let(:status) { 403 }
        it { expect(last_response.status).to eq 400 }
        it do
          expect(body).to eq(
            error: {
              type: 'unauthorized',
              service: 'github',
              ref: 'other/other:one.yml',
              message: 'Unable to authenticate with GitHub for file other/other:one.yml (GitHub GET repositories/1/contents/one.yml responded with 403)'
            }
          )
        end
      end

      describe '404' do
        let(:status) { 404 }
        it { expect(last_response.status).to eq 400 }
        it do
          expect(body).to eq(
            error: {
              type: 'file_not_found',
              service: 'github',
              ref: 'other/other:one.yml',
              message: 'File other/other:one.yml not found on GitHub (GitHub GET repositories/1/contents/one.yml responded with 404)'
            }
          )
        end
      end
    end
  end
end

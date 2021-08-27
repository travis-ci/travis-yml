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

  context 'when in a pull request' do
    let(:type) { :pull_request }
    let(:repo) { 'travis-ci/travis-yml' }
    let(:config) do
      {
        language: 'ruby',
        os: %w(linux),
        dist: 'xenial',
        arch: %w(amd64),
        rvm: %w(2.6.3),
        jobs: {
          include: [
            {
              stage: 'echo 1',
              script: [
                'echo $FOO'
              ]
            }
          ],
        },
        global_env: [
          {
            BAR: 'bar'
          },
          {
            secure: encr
          }
        ],
        group: 'stable'
      }
    end
    let(:data) { { config: config, data: yml_data } }
    let(:yml_data) { { repo: repo, head_repo: head_repo } }
    let(:encr) { 'HUJCiQuPbkZkcAPMUa8fqvm98b8s9oL4VyQ9xCzLwR0GHMQt0wROZP0B4Rr1+pbSC9tyEV0WB+jXMKtyxsQrgjO0qZmEbgrAlmn+roApm8Vvp/TQ/ieI69tzfit2OKoyhAdlbjMKclHP8FnbPV34oYa+pIA7BkcgC3OgRSYZL9g=' }
    let(:travis_yml) { "script: ./one\nenv:\n- FOO: foo\n- secure: #{encr}" }

    context 'when from fork' do
      let(:head_repo) { 'owner/travis-yml-fork' }

      before { post '/expand', Oj.generate(data) }

      it { expect(status).to eq 200 }
      it { expect(headers['Content-Type']).to eq 'application/json' }

      it do
        expect(body['matrix']).to eq(
          [
            {
              'os' => 'linux',
              'arch' => 'amd64',
              'rvm' => '2.6.3',
              'language' => 'ruby',
              'dist' => 'xenial',
              'group' => 'stable',
              'stage' => 'echo 1',
              'script' => ['echo $FOO'],
              'env' => [
                { 'BAR' => 'bar' },
                {}
              ]
            }
          ]
        )
      end
    end

    context 'when not from fork' do
      let(:head_repo) { repo }

      before { post '/expand', Oj.generate(data) }

      it { expect(status).to eq 200 }
      it { expect(headers['Content-Type']).to eq 'application/json' }

      it do
        expect(body['matrix']).to eq(
          [
            {
              'os' => 'linux',
              'arch' => 'amd64',
              'rvm' => '2.6.3',
              'language' => 'ruby',
              'dist' => 'xenial',
              'group' => 'stable',
              'stage' => 'echo 1',
              'script' => ['echo $FOO'],
              'env' => [
                { 'BAR' => 'bar' },
                { 'secure' => encr }
              ]
            }
          ]
        )
      end
    end
  end
end

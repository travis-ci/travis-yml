describe Travis::Yml::Schema::Def::Addons do
  include Travis::Yml::Helper::Obj

  let(:addons) { Travis::Yml.schema[:definitions][:type][:addons][:properties] }
  # let(:addons) { described_class.new.definitions[:type][:addons][:properties] }

  subject { addons }

  # it { puts JSON.pretty_generate(subject) }

  it { should include apt: { '$ref': '#/definitions/addon/apt' } }
  it { should include apt_packages: { '$ref': '#/definitions/type/strs' } }
  it { should include browserstack: { '$ref': '#/definitions/addon/browserstack' } }
  it { should include artifacts: { '$ref': '#/definitions/addon/artifacts' } }
  it { should include code_climate: { '$ref': '#/definitions/addon/code_climate' } }
  it { should include coverity_scan: { '$ref': '#/definitions/addon/coverity_scan' } }
  it { should include homebrew: { '$ref': '#/definitions/addon/homebrew' } }
  it { should include hostname: { type: :string } }
  it { should include hosts: { '$ref': '#/definitions/type/strs' } }
  it { should include jwt: { '$ref': '#/definitions/addon/jwts' } }
  it { should include sauce_connect: { '$ref': '#/definitions/addon/sauce_connect' } }
  it { should include snaps: { '$ref': '#/definitions/addon/snaps' } }
  it { should include firefox: { anyOf: [{ type: :number }, { type: :string }] } }
  it { should include mariadb: { type: :string } }
  it { should include postgresql: { type: :string, aliases: [:postgres] } }
  it { should include rethinkdb: { type: :string } }


  it do
    should include(
      ssh_known_hosts: {
        anyOf: [
          {
            type: :array,
            normal: true,
            items: {
              '$ref': '#/definitions/type/secure',
              strict: false
            }
          },
          {
            '$ref': '#/definitions/type/secure',
            strict: false
          },
        ]
      }
    )
  end
end

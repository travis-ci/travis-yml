describe Travis::Yml::Schema::Def::Addons do
  include Travis::Yml::Helper::Obj

  let(:addons) { Travis::Yml.schema[:definitions][:type][:addons][:properties] }
  # let(:addons) { described_class.new.definitions[:type][:addons][:properties] }

  subject { addons }

  # it { puts JSON.pretty_generate(subject) }

  it { should include apt: { '$ref': '#/definitions/addon/apt' } }
  it { should include apt_packages: { '$ref': '#/definitions/type/strs', summary: kind_of(String) } }
  it { should include browserstack: { '$ref': '#/definitions/addon/browserstack' } }
  it { should include artifacts: { '$ref': '#/definitions/addon/artifacts' } }
  it { should include chrome: { type: :string, enum: ['stable', 'beta'], downcase: true, summary: kind_of(String) } }
  it { should include code_climate: { '$ref': '#/definitions/addon/code_climate' } }
  it { should include coverity_scan: { '$ref': '#/definitions/addon/coverity_scan' } }
  it { should include homebrew: { '$ref': '#/definitions/addon/homebrew' } }
  it { should include hostname: { type: :string, summary: kind_of(String) } }
  it { should include hosts: { '$ref': '#/definitions/type/strs', summary: kind_of(String) } }
  it { should include jwt: { '$ref': '#/definitions/addon/jwts' } }
  it { should include sauce_connect: { '$ref': '#/definitions/addon/sauce_connect' } }
  it { should include snaps: { '$ref': '#/definitions/addon/snaps' } }
  it { should include firefox: { anyOf: [{ type: :number }, { type: :string }], example: '68.0b1', summary: kind_of(String) } }
  it { should include mariadb: { type: :string, summary: kind_of(String) } }
  it { should include postgresql: { type: :string, aliases: [:postgres], summary: kind_of(String) } }
  it { should include rethinkdb: { type: :string, summary: kind_of(String) } }
  it { should include ssh_known_hosts: { '$ref': '#/definitions/type/secures', strict: false, summary: kind_of(String), see: kind_of(Hash) } }
end

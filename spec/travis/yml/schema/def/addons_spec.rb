describe Travis::Yml::Schema::Def::Addons, 'structure' do
  describe 'definitions[:type]' do
    subject { Travis::Yml.schema[:definitions][:type][:addons][:properties] }

    # it { puts JSON.pretty_generate(described_class.new.exports) }

    it { should include apt: { '$ref': '#/definitions/addon/apt' } }
    it { should include apt_packages: { '$ref': '#/definitions/strs' } }
    it { should include browserstack: { '$ref': '#/definitions/addon/browserstack' } }
    it { should include artifacts: { '$ref': '#/definitions/addon/artifacts' } }
    it { should include code_climate: { '$ref': '#/definitions/addon/code_climate' } }
    it { should include coverity_scan: { '$ref': '#/definitions/addon/coverity_scan' } }
    it { should include homebrew: { '$ref': '#/definitions/addon/homebrew' } }
    it { should include hostname: { type: :string } }
    it { should include hosts: { '$ref': '#/definitions/strs' } }
    it { should include jwt: { '$ref': '#/definitions/addon/jwts' } }
    it { should include sauce_connect: { '$ref': '#/definitions/addon/sauce_connect' } }
    it { should include snaps: { '$ref': '#/definitions/addon/snaps' } }
    it { should include ssh_known_hosts: { '$ref': '#/definitions/strs' } }
    it { should include firefox: { type: :string } }
    it { should include mariadb: { type: :string } }
    it { should include postgresql: { type: :string } }
    it { should include rethinkdb: { type: :string } }
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/addons'
      )
    end
  end
end


describe Travis::Yml::Docs::Examples do
  let(:root) { Travis::Yml::Docs::Schema::Factory.build(nil, Travis::Yml.schema) }

  # map :apt
  # map :apt_packages,    to: :seq
  # map :artifacts
  # map :browserstack
  # map :chrome,          to: :str, values: %i(stable beta)
  # map :code_climate
  # map :coverity_scan
  # map :homebrew
  # map :hostname,        to: :str
  # map :hosts,           to: :seq
  # map :jwt,             to: :jwts
  # map :sauce_connect,   to: :sauce_connect
  # map :snaps
  #
  # # turn this into a proper addon definition
  # map :ssh_known_hosts, to: Class.new(Type::Seq) {
  #   def define
  #     type :secure, strict: false
  #   end
  # }
  # map :sonarcloud
  #
  # # turn this into a proper addon definition. the map allows the key debug: true
  # map :srcclr, to: Class.new(Type::Any) {
  #   def define
  #     type :map,  normal: true, strict: false
  #     type :bool, normal: true
  #   end
  # }
  #
  # map :firefox,         to: :any, type: [:num, :str], eg: '68.0b1'
  # map :mariadb,         to: :str
  # map :postgresql,      to: :str, alias: :postgres
  # map :rethinkdb,       to: :str
  # map :deploy,          to: :deploys

  describe 'firefox' do
    subject { root.includes[0][:addons][:firefox].examples }

    it do
      should eq [
        firefox: '68.0b1'
      ]
    end
  end
end

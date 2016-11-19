describe Travis::Yaml::Spec::Def::Addons do
  let(:spec) { described_class.new.spec }

  let(:addons) do
    %i(
      apt apt_packages browserstack artifacts code_climate coverity_scan
      hostname hosts jwt sauce_connect ssh_known_hosts sonarqube srcclr firefox
      mariadb postgresql rethinkdb deploy
    )
  end

  it { expect(except(spec, :map, :alias)).to eq(name: :addons, type: :map, strict: true) }
  it { expect(spec[:map].keys).to eq addons }

  describe 'apt_packages' do
    let(:addon) { spec[:map][:apt_packages] }
    it { expect(addon).to eq(key: :apt_packages, types: [type: :seq, types: [type: :scalar]]) }
  end

  describe 'hostname' do
    let(:addon) { spec[:map][:hostname] }
    it { expect(addon).to eq(key: :hostname, types: [type: :scalar]) }
  end

  describe 'hosts' do
    let(:addon) { spec[:map][:hosts] }
    it { expect(addon).to eq(key: :hosts, types: [type: :seq, types: [type: :scalar]]) }
  end

  describe 'ssh_known_hosts' do
    let(:addon) { spec[:map][:ssh_known_hosts] }
    it { expect(addon).to eq(key: :ssh_known_hosts, types: [type: :seq, types: [type: :scalar]]) }
  end

  describe 'sonarqube' do
    let(:addon) { spec[:map][:sonarqube] }
    it { expect(addon).to eq(key: :sonarqube, types: [{ type: :map, strict: false }, { type: :scalar, strict: false, cast: :bool }]) }
  end

  describe 'firefox' do
    let(:addon) { spec[:map][:firefox] }
    it { expect(addon).to eq(key: :firefox, types: [type: :scalar]) }
  end

  describe 'mariadb' do
    let(:addon) { spec[:map][:mariadb] }
    it { expect(addon).to eq(key: :mariadb, types: [type: :scalar]) }
  end

  describe 'postgresql' do
    let(:addon) { spec[:map][:postgresql] }
    it { expect(addon).to eq(key: :postgresql, types: [type: :scalar]) }
  end

  describe 'rethinkdb' do
    let(:addon) { spec[:map][:rethinkdb] }
    it { expect(addon).to eq(key: :rethinkdb, types: [type: :scalar]) }
  end
end


describe Travis::Yaml::Doc::Value::Node do
  let(:value) { { language: 'ruby', sudo: false, dist: nil, os: [], env: {}, token: { secure: 'secure' } } }
  let(:root)  { Travis::Yaml.build(value, alert: true) }
  let(:lang)  { root[:language] }
  let(:sudo)  { root[:sudo] }
  let(:dist)  { root[:dist] }
  let(:os)    { root[:os] }
  let(:env)   { root[:env] }
  let(:token) { root[:token] }

  describe 'type' do
    it { expect(lang.type).to eq :scalar }
  end

  describe 'root' do
    it { expect(root.root).to eq root }
    it { expect(lang.root).to eq root }
  end

  describe 'root?' do
    it { expect(root).to     be_root }
    it { expect(lang).not_to be_root }
  end

  describe 'is?' do
    it { expect(root.is?(:map)).to     be true }
    it { expect(os.is?(:seq)).to       be true }
    it { expect(lang.is?(:fixed)).to   be true }
    it { expect(lang.is?(:scalar)).to  be true }
    it { expect(sudo.is?(:scalar)).to  be true }
    it { expect(token.is?(:secure)).to be true }
  end

  describe 'str?' do
    it { expect(env).to_not   be_str }
    it { expect(os).to_not    be_str }
    it { expect(lang).to      be_str }
    it { expect(sudo).to_not  be_str }
    it { expect(token).to     be_str }
  end

  describe 'bool?' do
    it { expect(env).to_not   be_bool }
    it { expect(os).to_not    be_bool }
    it { expect(lang).to_not  be_bool }
    it { expect(sudo).to      be_bool }
    it { expect(token).to_not be_bool }
  end

  describe 'secure?' do
    it { expect(env).to_not   be_secure }
    it { expect(os).to_not    be_secure }
    it { expect(lang).to_not  be_secure }
    it { expect(token).to     be_secure }
  end

  describe 'present?' do
    it { expect(root).to      be_present }
    it { expect(env).to_not   be_present }
    it { expect(os).to_not    be_present }
    it { expect(lang).to      be_present }
    it { expect(token).to     be_present }
  end

  describe 'alert?' do
    it { expect(env).to       be_alert }
    it { expect(os).to        be_alert }
    it { expect(lang).to      be_alert }
    it { expect(token).to     be_alert }
  end

  describe 'supporting' do
    describe 'on root' do
      it { expect(root.supporting).to eq language: 'ruby' }
      it { expect(os.supporting).to eq   language: 'ruby' }
      it { expect(lang.supporting).to eq language: 'ruby' }
    end

    describe 'on a nested hash' do
      let(:value) { { matrix: { include: [{ language: 'go', os: 'osx' }] } } }
      let(:job)   { root[:matrix][:include][0] }
      it { expect(job.supporting).to eq language: 'go', os: 'osx' }
    end
  end

  describe 'warn' do
    before { token.warn :alert }
    it { expect(root.msgs).to include [:warn, :token, :alert] }
    it { expect(token.value).to_not be_nil }
  end

  describe 'error' do
    before { token.error :alert }
    it { expect(root.msgs).to include [:error, :token, :alert] }
    it { expect(token.value).to be_nil }
  end

  describe 'id' do
    let(:value) { { language: 'ruby', matrix: { include: [{ os: 'osx' }] } } }
    let(:job)   { root[:matrix][:include][0] }
    it { expect(lang.id).to eq :'root.language' }
    it { expect(job[:os].id).to eq :'root.matrix.include.include.os' }
  end

  describe 'full_key' do
    let(:value) { { language: 'ruby', matrix: { include: [{ os: 'osx' }] } } }
    let(:job)   { root[:matrix][:include][0] }
    it { expect(root.full_key).to eq :root }
    it { expect(lang.full_key).to eq :language }
    it { expect(job[:os].full_key).to eq :'matrix.include.os' }
  end

  describe 'walk' do
    let(:value) { { language: 'ruby', env: { FOO: 'foo' },  matrix: { include: [{ os: 'osx' }] } } }
    let(:ids)   { [] }

    before { root.walk { |node| ids << node.id } }

    it do
      expect(ids).to eq %i(
        root
        root.language
        root.env
        root.env.FOO
        root.matrix
        root.matrix.include
        root.matrix.include.include
        root.matrix.include.include.os
      )
    end
  end
end


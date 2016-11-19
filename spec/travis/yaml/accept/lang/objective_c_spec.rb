describe Travis::Yaml do
  subject { described_class.apply(input) }

  let(:config) { subject.serialize }
  let(:lang)   { 'objective-c' }

  let(:input) do
    {
      language: lang,
      xcode_sdk: 'macosx10.12',
      xcode_scheme: 'scheme',
      podfile: 'Podfile',
      xcode_project: 'project',
      xcode_workspace: 'workspace',
      xctool_args: 'args'
    }
  end

  it { expect(config[:language]).to eq 'objective-c' }

  it { expect(config[:xcode_sdk]).to eq ['macosx10.12'] }
  it { expect(config[:xcode_scheme]).to eq ['scheme'] }
  it { expect(config[:podfile]).to eq 'Podfile' }

  it { expect(config[:xcode_project]).to eq 'project' }
  it { expect(config[:xcode_workspace]).to eq 'workspace' }
  it { expect(config[:xctool_args]).to eq 'args' }

  %w(objc obj_c objective_c swift).each do |name|
    describe "alias #{name}" do
      let(:lang) { name }
      it { expect(config[:language]).to eq 'objective-c' }
      it { expect(info).to include [:info, :language, :alias, alias: name, value: 'objective-c'] }
    end
  end

  describe 'gemfile' do
    let(:input) { { language: 'objective-c', gemfile: ['Gemfile'] } }
    it { expect(config[:gemfile]).to eq ['Gemfile'] }
    it { expect(msgs).to be_empty }
  end

  describe 'bundler_args' do
    let(:input) { { language: 'objective-c', bundler_args: 'args' } }
    it { expect(config[:bundler_args]).to eq 'args' }
    it { expect(msgs).to be_empty }
  end

  describe 'xcode_sdk' do
    describe 'on objective-c' do
      let(:input) { { language: 'objective-c', os: 'osx', xcode_sdk: 'macosx10.12' } }
      it { expect(config[:xcode_sdk]).to eq ['macosx10.12'] }
      it { expect(msgs).to be_empty }
    end

    # TODO should these settings really depend on the language objective_c or
    # should they rather depend on the os osx?
    #
    # describe 'on shell' do
    #   let(:input) { { language: 'shell', os: 'osx', xcode_sdk: 'macosx10.12' } }
    #   it { expect(config[:xcode_sdk]).to eq ['macosx10.12'] }
    #   it { expect(msgs).to be_empty }
    # end
  end
end

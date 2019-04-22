describe Travis::Yml::Doc::Value::Support do
  let(:supporting) { { language: language, os: os } }
  let(:language) { 'ruby' }
  let(:os) { 'linux' }

  subject { described_class.new(support, supporting, obj) }

  describe 'arch' do
    let(:obj) { :arch }

    let(:support) { { only: { os: [ 'linux' ] } } }

    describe 'on linux' do
      let(:os) { 'linux' }
      it { should be_supported }
      it { should_not have_msg }
    end

    describe 'on osx' do
      let(:os) { 'osx' }
      it { should_not be_supported }
      it { should have_msg on_key: :os, on_value: 'osx' }
    end
  end

  describe 'osx_image' do
    let(:obj) { :osx_image }

    let(:support) { { only: { os: [ 'osx' ] } } }

    describe 'on linux' do
      let(:os) { 'linux' }
      it { should_not be_supported }
      it { should have_msg on_key: :os, on_value: 'linux' }
    end

    describe 'on osx' do
      let(:os) { 'osx' }
      it { should be_supported }
      it { should_not have_msg }
    end
  end

  describe 'jdk' do
    let(:obj) { :jdk }

    let(:support) { { only: { language: [ 'ruby' ] }, except: { os: [ 'osx' ] } } }

    describe 'on ruby' do
      let(:language) { 'ruby' }
      it { should be_supported }
      it { should_not have_msg }
    end

    describe 'on objective-c' do
      let(:language) { 'objective-c' }
      it { should_not be_supported }
      it { should have_msg }
    end

    describe 'on osx' do
      let(:os) { 'osx' }
      it { should_not be_supported }
      it { should have_msg on_key: :os, on_value: 'osx' }
    end

    describe 'on jave on osx' do
      let(:language) { 'java' }
      let(:os) { 'osx' }
      it { should_not be_supported }
      it { should have_msg on_key: :os, on_value: 'osx' }
    end

    describe 'multios' do
      let(:os) { ['linux', 'osx'] }
      it { should be_supported }
      it { should_not have_msg }
    end
  end

  describe 'linux' do
    let(:obj) { :linux }
    let(:support) { { except: { language: [ 'objective-c' ] } } }

    describe 'on ruby' do
      let(:language) { 'ruby' }
      it { should be_supported }
      it { should_not have_msg }
    end

    describe 'on objective-c' do
      let(:language) { 'objective-c' }
      it { should_not be_supported }
      it { should have_msg on_key: :language, on_value: 'objective-c' }
    end
  end

  describe 'osx' do
    let(:obj) { :osx }
    let(:support) { { except: { language: [ 'php' ] } } }

    describe 'on ruby' do
      let(:language) { 'ruby' }
      it { should be_supported }
      it { should_not have_msg }
    end

    describe 'on php' do
      let(:language) { 'php' }
      it { should_not be_supported }
      it { should have_msg on_key: :language, on_value: 'php' }
    end
  end

  describe 'windows' do
    let(:obj) { :windows }
    let(:support) { { only: { language: [ 'shell' ] } } }

    describe 'on shell' do
      let(:language) { 'shell' }
      it { should be_supported }
      it { should_not have_msg }
    end

    describe 'on php' do
      let(:language) { 'php' }
      it { should_not be_supported }
      it { should have_msg on_key: :language, on_value: 'php' }
    end
  end
end

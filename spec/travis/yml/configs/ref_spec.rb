describe Travis::Yml::Configs::Ref do
  let(:opts) { {} }

  subject { described_class.new(str, opts).parts }

  describe 'empty string' do
    let(:str) { '' }
    it { expect { subject }.to raise_error Travis::Yml::Configs::InvalidRef }
  end

  describe 'remote' do
    describe 'file in root dir' do
      let(:str) { 'owner/repo:file.yml@v1' }
      it { should eq ['owner/repo', 'file.yml', 'v1'] }
    end

    describe 'file in sub dir' do
      let(:str) { 'owner/repo:path/to/file.yml@v1' }
      it { should eq ['owner/repo', 'path/to/file.yml', 'v1'] }
    end

    describe 'file name containing an @' do
      let(:str) { 'owner/repo:@file.yml@v1' }
      it { should eq ['owner/repo', '@file.yml', 'v1'] }
    end

    describe 'dir name containing an @' do
      let(:str) { 'owner/repo:@path/to/file.yml@v1' }
      it { should eq ['owner/repo', '@path/to/file.yml', 'v1'] }
    end

    describe 'no ref given' do
      let(:str) { 'owner/repo:file.yml' }
      it { should eq ['owner/repo', 'file.yml', nil] }
    end

    describe 'no file name given' do
      let(:str) { 'owner/repo@v1' }
      it { expect { subject }.to raise_error Travis::Yml::Configs::InvalidRef }
    end

    describe 'given a json file name' do
      let(:str) { 'owner/repo:.travis.json@v1' }
      it { expect { subject }.to raise_error Travis::Yml::Configs::InvalidRef }
    end
  end

  describe 'local' do
    describe 'file in root dir' do
      let(:str) { 'file.yml@v1' }
      it { should eq [nil, 'file.yml', 'v1'] }
    end

    describe 'file in sub dir' do
      let(:str) { 'path/to/file.yml@v1' }
      it { should eq [nil, 'path/to/file.yml', 'v1'] }
    end

    describe 'file name containing an @' do
      let(:str) { '@file.yml@v1' }
      it { should eq [nil, '@file.yml', 'v1'] }
    end

    describe 'dir name containing an @' do
      let(:str) { '@path/to/file.yml@v1' }
      it { should eq [nil, '@path/to/file.yml', 'v1'] }
    end

    describe 'no ref given' do
      let(:str) { 'file.yml' }
      it { should eq [nil, 'file.yml', nil] }
    end

    describe 'no file name given' do
      let(:str) { '@v1' }
      it { expect { subject }.to raise_error Travis::Yml::Configs::InvalidRef }
    end

    describe 'given a json file name' do
      let(:str) { '.travis.json@v1' }
      it { expect { subject }.to raise_error Travis::Yml::Configs::InvalidRef }
    end
  end

  describe 'relative' do
    describe 'imported from root' do
      let(:opts) { { path: 'importing.yml' } }

      describe 'file in root' do
        let(:str) { './file.yml' }
        it { should eq [nil, 'file.yml', nil] }
      end

      describe 'file in sub dir' do
        let(:str) { 'path/to/file.yml' }
        it { should eq [nil, 'path/to/file.yml', nil] }
      end
    end

    describe 'imported from sub dir' do
      let(:opts) { { path: 'importing/file.yml' } }

      describe 'file in root' do
        let(:str) { './file.yml' }
        it { should eq [nil, 'importing/file.yml', nil] }
      end

      describe 'file in sub dir' do
        let(:str) { './path/to/file.yml' }
        it { should eq [nil, 'importing/path/to/file.yml', nil] }
      end
    end
  end
end

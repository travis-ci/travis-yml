describe Travis::Yaml::Load do
  let(:api) do
    <<~yml
      script: ./api
      env:
        api: true
        foo: 1
    yml
  end

  let(:travis_yml) do
    <<~yml
      script: ./travis_yml
      env:
        travis_yml: true
        foo: 2
    yml
  end

  let(:import) do
    <<~yml
      script: ./import
      env:
        import: true
        foo: 3
    yml
  end

  subject { described_class.apply(parts).to_h }

  describe 'given a single string' do
    let(:parts) { api }
    it { should eq 'script' => './api', 'env' => { 'api' => true, 'foo' => '1' }  }
  end

  describe 'given an array of strings (defaults to merge)' do
    let(:parts) { [api, travis_yml, import] }
    it { should eq 'script' => './api', 'env' => { 'api' => true, 'foo' => '1' }  }
  end

  describe 'given an array of Parts' do
    let(:parts) do
      [
        Travis::Yaml::Part.new(api, 'api.yml', nil),
        Travis::Yaml::Part.new(travis_yml, '.travis.yml', mode),
        Travis::Yaml::Part.new(import, 'import.yml', mode)
      ]
    end

    describe 'merge' do
      let(:mode) { :merge }
      it { should eq 'script' => './api', 'env' => { 'api' => true, 'foo' => '1' }  }
    end

    describe 'deep_merge' do
      let(:mode) { :deep_merge }
      it { should eq 'script' => './api', 'env' => { 'api' => true, 'foo' => '1', 'travis_yml' => true, 'import' => true }  }
      it { expect(subject['env'].to_a).to eq [['import', true], ['foo', '1'], ['travis_yml', true], ['api', true]] }
    end
  end
end

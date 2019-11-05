describe Travis::Yml::Parts::Merge do
  let(:api) do
    <<~yaml
      script: ./api
      env:
        api: true
        foo: 1
    yaml
  end

  let(:travis_yml) do
    <<~yaml
      language: shell
      script: ./travis_yml
      env:
        travis_yml: true
        foo: 2
    yaml
  end

  let(:import) do
    <<~yaml
      script: ./import
      env:
        foo: 3
        import: true
    yaml
  end

  let(:parts) do
    [
      part(api, 'api.yml', nil),
      part(travis_yml, '.travis.yml', mode),
      part(import, 'import.yml', mode)
    ]
  end

  subject { symbolize(described_class.new(parts).apply) }

  def part(yaml, source = nil, mode = nil)
    Travis::Yml::Parts::Part.new(yaml, source, mode)
  end

  describe 'merge_mode' do
    describe 'replace' do
      let(:mode) { :replace }

      it do
        should eq(
          script: './api',
          env: {
            api: true,
            foo: 1
          }
        )
      end
    end

    describe 'merge' do
      let(:mode) { :merge }

      it do
        should eq(
          language: 'shell',
          script: './api',
          env: {
            api: true,
            foo: 1
          }
        )
      end
    end

    describe 'deep_merge' do
      let(:mode) { :deep_merge }

      it do
        should eq(
          language: 'shell',
          script: './api',
          env: {
            api: true,
            foo: 1,
            travis_yml: true,
            import: true,
          }
        )
      end

      it do
        expect(subject[:env]).to eq(
          api: true,
          foo: 1,
          travis_yml: true,
          import: true
        )
      end
    end
  end

  describe 'merge tags' do
    let(:parts) { [part(lft), part(rgt)] }

    let(:rgt) do
      <<~yml
        foo:
          bar:
          - two
      yml
    end

    describe 'deep_merge+append on root' do
      let(:lft) do
        <<~yml
          !map+deep_merge+append
          foo:
            bar:
            - one
        yml
      end

      it { expect(subject[:foo][:bar]).to be_a Array } # Seq??
      it { should eq foo: { bar: ['one', 'two'] } }
    end

    describe 'deep_merge on root, deep_merge+append on child' do
      let(:lft) do
        <<~yml
          !map+deep_merge
          foo:
            !map+deep_merge+append
            bar:
            - one
        yml
      end

      it { expect(subject[:foo][:bar]).to be_a Array } # Seq??
      it { should eq foo: { bar: ['one', 'two'] } }
    end

    describe 'deep_merge on root, append on child' do
      let(:lft) do
        <<~yml
          !map+deep_merge
          foo:
            bar: !seq+append
            - one
        yml
      end

      it { should eq foo: { bar: ['one', 'two'] } }
    end
  end

  describe 'default merge mode on nested imports' do
    let(:parts) { [part(one), part(two), part(three)] }

    let(:one) do
      <<~yml
      env:
        global:
          - ONE=one
      yml
    end

    let(:two) do
      <<~yml
        env:
          global:
            - TWO=two
      yml
    end

    let(:three) do
      <<~yml
        env:
          global:
            - THREE=three
      yml
    end

    it { should eq env: { global: ['ONE=one', 'TWO=two', 'THREE=three'] } }
  end

  describe 'merge mode and merge tags' do
    let(:parts) { [part(one), part(two, nil, :deep_merge), part(three)] }

    let(:one) do
      <<~yml
      env:
        global: !seq+append
          - ONE=one
      yml
    end

    let(:two) do
      <<~yml
        env:
          global:
            - TWO=two
      yml
    end

    let(:three) do
      <<~yml
        env:
          global:
            - THREE=three
      yml
    end

    it { should eq env: { global: ['ONE=one', 'TWO=two', 'THREE=three'] } }
  end

  describe 'src and line' do
    let(:merged) { described_class.new(parts).apply }
    let(:mode) { :deep_merge }

    describe 'script' do
      subject { merged.keys[0] }

      it { should be_a Key }
      it { should eq 'script' }
      it { should have_attributes src: 'api.yml', line: 0 }
    end

    describe 'env' do
      subject { merged.keys[1] }

      it { should be_a Key }
      it { should eq 'env' }
      it { should have_attributes src: 'api.yml', line: 1 }
    end

    describe 'api' do
      subject { merged['env'].keys[0] }

      it { should be_a Key }
      it { should eq 'api' }
      it { should have_attributes src: 'api.yml', line: 2 }
    end

    describe 'foo' do
      subject { merged['env'].keys[1] }

      it { should be_a Key }
      it { should eq 'foo' }
      it { should have_attributes src: 'api.yml', line: 3 }
    end

    describe 'travis_yml' do
      subject { merged['env'].keys[2] }

      it { should be_a Key }
      it { should eq 'travis_yml' }
      it { should have_attributes src: '.travis.yml', line: 3 }
    end

    describe 'import' do
      subject { merged['env'].keys[3] }

      it { should be_a Key }
      it { should eq 'import' }
      it { should have_attributes src: 'import.yml', line: 3 }
    end
  end

end

describe Travis::Yml, 'branches' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a bool' do
    yaml %(
      branches: true
    )
    it { should serialize_to branches: { only: ['true'] } }
    xit { should have_msg [:info, :'branches.only', :cast, given_value: true, given_type: :bool, value: 'true', type: :str] }
  end

  describe 'given a string' do
    yaml %(
      branches: master
    )
    it { should serialize_to branches: { only: ['master'] } }
  end

  describe 'given a seq' do
    yaml %(
      branches:
      - master
    )
    let(:value) { { branches: [only: 'master'] } }
    it { should serialize_to branches: { only: ['master'] } }
  end

  describe 'given a typo on the key' do
    yaml %(
      barnches: master
    )
    it { should serialize_to branches: { only: ['master'] } }
  end

  describe 'only' do
    describe 'given a string' do
      yaml %(
        branches:
          only: master
      )
      it { should serialize_to branches: { only: ['master'] } }
    end

    describe 'given a seq' do
      yaml %(
        branches:
          only:
          - master
      )
      it { should serialize_to branches: { only: ['master'] } }
    end

    describe 'given a seq of hashes' do
      yaml %(
        branches:
        - only: master
      )
      it { should serialize_to branches: { only: ['master'] } }
    end

    describe 'given a typo on the key' do
      yaml %(
        barnches:
          olny: master
      )
      it { should serialize_to branches: { only: ['master'] } }
    end
  end

  describe 'except' do
    describe 'given a string' do
      yaml %(
        branches:
          except: master
      )
      it { should serialize_to branches: { except: ['master'] } }
    end

    describe 'given a seq' do
      yaml %(
        branches:
          except:
          - master
      )
      it { should serialize_to branches: { except: ['master'] } }
    end

    describe 'given a seq of hashes' do
      yaml %(
        branches:
          - except: master
      )
      it { should serialize_to branches: { except: ['master'] } }
    end
  end

  describe 'exclude (alias)' do
    yaml %(
      branches:
        exclude: master
    )
    it { should serialize_to branches: { except: ['master'] } }
    it { should have_msg [:info, :branches, :alias, alias: 'exclude', key: 'except'] }
  end

  describe 'given an unknown key' do
    yaml %(
      branches:
        foo: master
    )
    it { should serialize_to branches: { foo: 'master' } }
    it { should have_msg [:warn, :branches, :unknown_key, key: 'foo', value: 'master'] }
  end
end

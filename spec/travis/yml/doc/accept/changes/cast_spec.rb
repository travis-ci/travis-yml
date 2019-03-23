describe Travis::Yml, 'cast' do
  let(:empty) { {} }
  subject { described_class.apply(value) }

  describe 'filter_secrets' do
    describe 'given true' do
      let(:value) { { filter_secrets: true } }
      it { should serialize_to filter_secrets: true }
      it { should_not have_msg }
    end

    describe 'given "true"' do
      let(:value) { { filter_secrets: 'true' } }
      it { should serialize_to filter_secrets: true }
      it { should_not have_msg }
    end

    describe 'given "required"' do
      let(:value) { { filter_secrets: 'required' } }
      it { should serialize_to filter_secrets: true }
      it { should_not have_msg }
    end

    describe 'given 1' do
      let(:value) { { filter_secrets: 1 } }
      it { should serialize_to empty }
      it { should have_msg [:error, :filter_secrets, :invalid_type, expected: :bool, actual: :num, value: 1] }
    end
  end

  describe 'group' do
    describe 'given true' do
      let(:value) { { group: true } }
      it { should serialize_to group: 'true' }
      it { should have_msg [:info, :group, :cast, given_value: true, given_type: :bool, value: 'true', type: :str] }
    end

    describe 'given "str"' do
      let(:value) { { group: 'str' } }
      it { should serialize_to group: 'str' }
      it { should_not have_msg }
    end

    describe 'given 1' do
      let(:value) { { group: 1 } }
      it { should serialize_to group: '1' }
      it { should have_msg [:info, :group, :cast, given_value: 1, given_type: :num, value: '1', type: :str] }
    end
  end

  describe 'script' do
    describe 'given true' do
      let(:value) { { script: true } }
      it { should serialize_to script: ['true'] }
      it { should have_msg [:info, :script, :cast, given_value: true, given_type: :bool, value: 'true', type: :str] }
    end

    describe 'given "str"' do
      let(:value) { { script: 'str' } }
      it { should serialize_to script: ['str'] }
      it { should_not have_msg }
    end

    describe 'given 1' do
      let(:value) { { script: 1 } }
      it { should serialize_to script: ['1'] }
      it { should have_msg [:info, :script, :cast, given_value: 1, given_type: :num, value: '1', type: :str] }
    end
  end

  describe 'git.submodules_depth' do
    describe 'given true' do
      let(:value) { { git: { submodules_depth: true } } }
      it { should serialize_to empty }
      it { should have_msg [:error, :'git.submodules_depth', :invalid_type, expected: :num, actual: :bool, value: true] }
    end

    describe 'given "str"' do
      let(:value) { { git: { submodules_depth: 'str' } } }
      it { should serialize_to empty }
      it { should have_msg [:error, :'git.submodules_depth', :invalid_type, expected: :num, actual: :str, value: 'str'] }
    end

    describe 'given 1' do
      let(:value) { { git: { submodules_depth: 1 } } }
      it { should serialize_to git: { submodules_depth: 1 } }
      it { should_not have_msg }
    end

    describe 'given "1"' do
      let(:value) { { git: { submodules_depth: '1' } } }
      it { should serialize_to git: { submodules_depth: 1 } }
      it { should_not have_msg }
    end
  end
end

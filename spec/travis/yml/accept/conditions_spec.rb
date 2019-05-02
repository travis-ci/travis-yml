describe Travis::Yml, 'conditions' do
  subject { described_class.apply(parse(yaml)) }

  describe 'build' do
    describe 'v0' do
      describe 'branch = master' do
        yaml %(
          conditions: v0
          if: 'branch = master'
        )
        it { should serialize_to if: 'branch = master', conditions: 'v0' }
        it { should_not have_msg }
      end

      describe 'true (bool)' do
        yaml %(
          conditions: v0
          if: true
        )
        it { should have_msg [:error, :if, :invalid_condition, condition: 'true'] }
      end

      describe 'true (str)' do
        yaml %(
          conditions: v0
          if: 'true'
        )
        it { should have_msg [:error, :if, :invalid_condition, condition: 'true'] }
      end
    end

    describe 'v1' do
      describe 'branch = master' do
        yaml %(
          conditions: v1
          if: 'branch = master'
        )
        it { should serialize_to conditions: 'v1', if: 'branch = master' }
        it { should_not have_msg }
      end

      describe 'true (bool)' do
        yaml %(
          conditions: v1
          if: true
        )
        it { should serialize_to conditions: 'v1', if: 'true' }
        xit { should have_msg [:info, :if, :cast, given_value: true, given_type: :bool, value: 'true', type: :str] }
      end

      describe 'true (str)' do
        yaml %(
          conditions: v1
          if: 'true'
        )
        it { should serialize_to conditions: 'v1', if: 'true' }
        it { should_not have_msg }
      end

      describe '= foo' do
        yaml %(
          if: '= foo'
        )
        it { should serialize_to empty }
        it { should have_msg [:error, :if, :invalid_condition, condition: '= foo'] }
      end
    end

    describe 'v1 (default)', v2: true, defaults: true do
      describe 'branch = master' do
        yaml %(
          if: 'branch = master'
        )
        it { should serialize_to if: 'branch = master' }
        it { should_not have_msg }
      end

      describe 'true' do
        yaml %(
          if: true
        )
        it { should serialize_to if: 'true' }
        xit { should have_msg [:info, :if, :cast, given_value: true, given_type: :bool, value: 'true', type: :str] }
      end

      describe '= foo' do
        yaml %(
          if: '= foo'
        )
        it { should serialize_to empty }
        it { should have_msg [:error, :if, :invalid_condition, condition: '= foo'] }
      end
    end
  end

  describe 'stages' do
    describe 'true' do
      yaml %(
        stages:
          - if: 'branch = master'
      )
      it { should serialize_to stages: [if: 'branch = master'] }
    end
  end

  describe 'job' do
    describe 'true' do
      yaml %(
        jobs:
          - if: 'branch = master'
      )
      it { should serialize_to matrix: { include: [if: 'branch = master'] } }
    end
  end
end

describe Travis::Yml, 'ruby' do
  subject { described_class.load(yaml) }

  describe 'rvm' do
    describe 'given a seq of strs' do
      yaml %(
        rvm:
        - str
      )
      it { should serialize_to rvm: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        rvm: str
      )
      it { should serialize_to rvm: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'gemfile' do
    describe 'given a seq of strs' do
      yaml %(
        gemfile:
        - str
      )
      it { should serialize_to gemfile: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        gemfile: str
      )
      it { should serialize_to gemfile: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'jdk' do
    describe 'given a seq of strs' do
      yaml %(
        jdk:
        - str
      )
      it { should serialize_to jdk: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        jdk: str
      )
      it { should serialize_to jdk: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'bundler_args' do
    describe 'given a str' do
      yaml %(
        bundler_args: str
      )
      it { should serialize_to bundler_args: 'str' }
    end
  end
end

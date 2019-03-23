require 'travis/yml/support/version'

describe Version do
  subject { described_class.new(version) }

  describe '~>' do
    describe '2' do
      let(:version) { '2' }

      it { should_not be_satisfies '~> 1' }
      it { should_not be_satisfies '~> 1.1' }
      it { should_not be_satisfies '~> 1.1.1' }
      it { should     be_satisfies '~> 2' }
      it { should     be_satisfies '~> 2.3' }
      it { should     be_satisfies '~> 2.3.3' }
      it { should     be_satisfies '~> 2.3.4' }
      it { should     be_satisfies '~> 2.3.5' }
      it { should     be_satisfies '~> 2.4' }
      it { should_not be_satisfies '~> 3' }
      it { should_not be_satisfies '~> 3.1' }
      it { should_not be_satisfies '~> 3.1.1' }
    end

    describe '2.3' do
      let(:version) { '2.3' }

      it { should_not be_satisfies '~> 1' }
      it { should_not be_satisfies '~> 1.1' }
      it { should_not be_satisfies '~> 1.1.1' }
      it { should     be_satisfies '~> 2' }
      it { should     be_satisfies '~> 2.3' }
      it { should     be_satisfies '~> 2.3.3' }
      it { should     be_satisfies '~> 2.3.4' }
      it { should     be_satisfies '~> 2.3.5' }
      it { should_not be_satisfies '~> 2.4' }
      it { should_not be_satisfies '~> 3' }
      it { should_not be_satisfies '~> 3.1' }
      it { should_not be_satisfies '~> 3.1.1' }
    end

    describe '2.3.4' do
      let(:version) { '2.3.4' }

      it { should_not be_satisfies '~> 1' }
      it { should_not be_satisfies '~> 1.1' }
      it { should_not be_satisfies '~> 1.1.1' }
      it { should     be_satisfies '~> 2' }
      it { should     be_satisfies '~> 2.3' }
      it { should     be_satisfies '~> 2.3.3' }
      it { should     be_satisfies '~> 2.3.4' }
      it { should_not be_satisfies '~> 2.3.5' }
      it { should_not be_satisfies '~> 2.4' }
      it { should_not be_satisfies '~> 3' }
      it { should_not be_satisfies '~> 3.1' }
      it { should_not be_satisfies '~> 3.1.1' }
    end
  end

  describe '>' do
    describe '2' do
      let(:version) { '2' }

      it { should     be_satisfies '> 1' }
      it { should     be_satisfies '> 1.1' }
      it { should     be_satisfies '> 1.1.1' }
      it { should_not be_satisfies '> 2' }
      it { should_not be_satisfies '> 2.3' }
      it { should_not be_satisfies '> 2.3.3' }
      it { should_not be_satisfies '> 2.3.4' }
      it { should_not be_satisfies '> 2.3.5' }
      it { should_not be_satisfies '> 2.4' }
      it { should_not be_satisfies '> 3' }
      it { should_not be_satisfies '> 3.1' }
      it { should_not be_satisfies '> 3.1.1' }
    end

    describe '2.3' do
      let(:version) { '2.3' }

      it { should     be_satisfies '> 1' }
      it { should     be_satisfies '> 1.1' }
      it { should     be_satisfies '> 1.1.1' }
      it { should     be_satisfies '> 2' }
      it { should_not be_satisfies '> 2.3' }
      it { should_not be_satisfies '> 2.3.3' }
      it { should_not be_satisfies '> 2.3.4' }
      it { should_not be_satisfies '> 2.3.5' }
      it { should_not be_satisfies '> 2.4' }
      it { should_not be_satisfies '> 3' }
      it { should_not be_satisfies '> 3.1' }
      it { should_not be_satisfies '> 3.1.1' }
    end

    describe '2.3.4' do
      let(:version) { '2.3.4' }

      it { should     be_satisfies '> 1' }
      it { should     be_satisfies '> 1.1' }
      it { should     be_satisfies '> 1.1.1' }
      it { should     be_satisfies '> 2' }
      it { should     be_satisfies '> 2.3' }
      it { should     be_satisfies '> 2.3.3' }
      it { should_not be_satisfies '> 2.3.4' }
      it { should_not be_satisfies '> 2.3.5' }
      it { should_not be_satisfies '> 2.4' }
      it { should_not be_satisfies '> 3' }
      it { should_not be_satisfies '> 3.1' }
      it { should_not be_satisfies '> 3.1.1' }
    end
  end

  describe '>=' do
    describe '2' do
      let(:version) { '2' }

      it { should     be_satisfies '>= 1' }
      it { should     be_satisfies '>= 1.1' }
      it { should     be_satisfies '>= 1.1.1' }
      it { should     be_satisfies '>= 2' }
      it { should_not be_satisfies '>= 2.3' }
      it { should_not be_satisfies '>= 2.3.3' }
      it { should_not be_satisfies '>= 2.3.4' }
      it { should_not be_satisfies '>= 2.3.5' }
      it { should_not be_satisfies '>= 2.4' }
      it { should_not be_satisfies '>= 3' }
      it { should_not be_satisfies '>= 3.1' }
      it { should_not be_satisfies '>= 3.1.1' }
    end

    describe '2.3' do
      let(:version) { '2.3' }

      it { should     be_satisfies '>= 1' }
      it { should     be_satisfies '>= 1.1' }
      it { should     be_satisfies '>= 1.1.1' }
      it { should     be_satisfies '>= 2' }
      it { should     be_satisfies '>= 2.3' }
      it { should_not be_satisfies '>= 2.3.3' }
      it { should_not be_satisfies '>= 2.3.4' }
      it { should_not be_satisfies '>= 2.3.5' }
      it { should_not be_satisfies '>= 2.4' }
      it { should_not be_satisfies '>= 3' }
      it { should_not be_satisfies '>= 3.1' }
      it { should_not be_satisfies '>= 3.1.1' }
    end

    describe '2.3.4' do
      let(:version) { '2.3.4' }

      it { should     be_satisfies '>= 1' }
      it { should     be_satisfies '>= 1.1' }
      it { should     be_satisfies '>= 1.1.1' }
      it { should     be_satisfies '>= 2' }
      it { should     be_satisfies '>= 2.3' }
      it { should     be_satisfies '>= 2.3.3' }
      it { should     be_satisfies '>= 2.3.4' }
      it { should_not be_satisfies '>= 2.3.5' }
      it { should_not be_satisfies '>= 2.4' }
      it { should_not be_satisfies '>= 3' }
      it { should_not be_satisfies '>= 3.1' }
      it { should_not be_satisfies '>= 3.1.1' }
    end
  end

  describe '<=' do
    describe '2' do
      let(:version) { '2' }

      it { should_not be_satisfies '<= 1' }
      it { should_not be_satisfies '<= 1.1' }
      it { should_not be_satisfies '<= 1.1.1' }
      it { should     be_satisfies '<= 2' }
      it { should     be_satisfies '<= 2.3' }
      it { should     be_satisfies '<= 2.3.3' }
      it { should     be_satisfies '<= 2.3.4' }
      it { should     be_satisfies '<= 2.3.5' }
      it { should     be_satisfies '<= 2.4' }
      it { should     be_satisfies '<= 3' }
      it { should     be_satisfies '<= 3.1' }
      it { should     be_satisfies '<= 3.1.1' }
    end

    describe '2.3' do
      let(:version) { '2.3' }

      it { should_not be_satisfies '<= 1' }
      it { should_not be_satisfies '<= 1.1' }
      it { should_not be_satisfies '<= 1.1.1' }
      it { should_not be_satisfies '<= 2' }
      it { should     be_satisfies '<= 2.3' }
      it { should     be_satisfies '<= 2.3.3' }
      it { should     be_satisfies '<= 2.3.4' }
      it { should     be_satisfies '<= 2.3.5' }
      it { should     be_satisfies '<= 2.4' }
      it { should     be_satisfies '<= 3' }
      it { should     be_satisfies '<= 3.1' }
      it { should     be_satisfies '<= 3.1.1' }
    end

    describe '2.3.4' do
      let(:version) { '2.3.4' }

      it { should_not be_satisfies '<= 1' }
      it { should_not be_satisfies '<= 1.1' }
      it { should_not be_satisfies '<= 1.1.1' }
      it { should_not be_satisfies '<= 2' }
      it { should_not be_satisfies '<= 2.3' }
      it { should_not be_satisfies '<= 2.3.3' }
      it { should     be_satisfies '<= 2.3.4' }
      it { should     be_satisfies '<= 2.3.5' }
      it { should     be_satisfies '<= 2.4' }
      it { should     be_satisfies '<= 3' }
      it { should     be_satisfies '<= 3.1' }
      it { should     be_satisfies '<= 3.1.1' }
    end
  end

  describe '<' do
    describe '2' do
      let(:version) { '2' }

      it { should_not be_satisfies '< 1' }
      it { should_not be_satisfies '< 1.1' }
      it { should_not be_satisfies '< 1.1.1' }
      it { should_not be_satisfies '< 2' }
      it { should     be_satisfies '< 2.3' }
      it { should     be_satisfies '< 2.3.3' }
      it { should     be_satisfies '< 2.3.4' }
      it { should     be_satisfies '< 2.3.5' }
      it { should     be_satisfies '< 2.4' }
      it { should     be_satisfies '< 3' }
      it { should     be_satisfies '< 3.1' }
      it { should     be_satisfies '< 3.1.1' }
    end

    describe '2.3' do
      let(:version) { '2.3' }

      it { should_not be_satisfies '< 1' }
      it { should_not be_satisfies '< 1.1' }
      it { should_not be_satisfies '< 1.1.1' }
      it { should_not be_satisfies '< 2' }
      it { should_not be_satisfies '< 2.3' }
      it { should     be_satisfies '< 2.3.3' }
      it { should     be_satisfies '< 2.3.4' }
      it { should     be_satisfies '< 2.3.5' }
      it { should     be_satisfies '< 2.4' }
      it { should     be_satisfies '< 3' }
      it { should     be_satisfies '< 3.1' }
      it { should     be_satisfies '< 3.1.1' }
    end

    describe '2.3.4' do
      let(:version) { '2.3.4' }

      it { should_not be_satisfies '< 1' }
      it { should_not be_satisfies '< 1.1' }
      it { should_not be_satisfies '< 1.1.1' }
      it { should_not be_satisfies '< 2' }
      it { should_not be_satisfies '< 2.3' }
      it { should_not be_satisfies '< 2.3.3' }
      it { should_not be_satisfies '< 2.3.4' }
      it { should     be_satisfies '< 2.3.5' }
      it { should     be_satisfies '< 2.4' }
      it { should     be_satisfies '< 3' }
      it { should     be_satisfies '< 3.1' }
      it { should     be_satisfies '< 3.1.1' }
    end
  end

  describe '=' do
    describe '2' do
      let(:version) { '2' }

      it { should_not be_satisfies '= 1' }
      it { should_not be_satisfies '= 1.1' }
      it { should_not be_satisfies '= 1.1.1' }
      it { should     be_satisfies '= 2' }
      it { should_not be_satisfies '= 2.3' }
      it { should_not be_satisfies '= 2.3.3' }
      it { should_not be_satisfies '= 2.3.4' }
      it { should_not be_satisfies '= 2.3.5' }
      it { should_not be_satisfies '= 2.4' }
      it { should_not be_satisfies '= 3' }
      it { should_not be_satisfies '= 3.1' }
      it { should_not be_satisfies '= 3.1.1' }
    end

    describe '2.3' do
      let(:version) { '2.3' }

      it { should_not be_satisfies '= 1' }
      it { should_not be_satisfies '= 1.1' }
      it { should_not be_satisfies '= 1.1.1' }
      it { should_not be_satisfies '= 2' }
      it { should     be_satisfies '= 2.3' }
      it { should_not be_satisfies '= 2.3.3' }
      it { should_not be_satisfies '= 2.3.4' }
      it { should_not be_satisfies '= 2.3.5' }
      it { should_not be_satisfies '= 2.4' }
      it { should_not be_satisfies '= 3' }
      it { should_not be_satisfies '= 3.1' }
      it { should_not be_satisfies '= 3.1.1' }
    end

    describe '2.3.4' do
      let(:version) { '2.3.4' }

      it { should_not be_satisfies '= 1' }
      it { should_not be_satisfies '= 1.1' }
      it { should_not be_satisfies '= 1.1.1' }
      it { should_not be_satisfies '= 2' }
      it { should_not be_satisfies '= 2.3' }
      it { should_not be_satisfies '= 2.3.3' }
      it { should     be_satisfies '= 2.3.4' }
      it { should_not be_satisfies '= 2.3.5' }
      it { should_not be_satisfies '= 2.4' }
      it { should_not be_satisfies '= 3' }
      it { should_not be_satisfies '= 3.1' }
      it { should_not be_satisfies '= 3.1.1' }
    end
  end
end

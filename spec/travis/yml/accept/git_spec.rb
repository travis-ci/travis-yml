describe Travis::Yml do
  accept 'git' do
    describe 'quiet' do
      yaml %(
        git:
          quiet: true
      )
      it { should serialize_to git: { quiet: true } }
      it { should_not have_msg }
    end

    describe 'depth' do
      describe 'given a num' do
        yaml %(
          git:
            depth: 1
        )
        it { should serialize_to git: { depth: 1 } }
        it { should_not have_msg }
      end

      describe 'given a str' do
        yaml %(
          git:
            depth: '1'
        )
        it { should serialize_to git: { depth: 1 } }
        it { should_not have_msg }
      end
    end

    describe 'submodules' do
      describe 'given a bool' do
        yaml %(
          git:
            submodules: false
        )
        it { should serialize_to git: { submodules: false } }
        it { should_not have_msg }
      end

      describe 'given a str' do
        yaml %(
          git:
            submodules: off
        )
        it { should serialize_to git: { submodules: false } }
        it { should_not have_msg }
      end
    end

    describe 'submodules_depth' do
      yaml %(
        git:
          submodules_depth: 10
      )
      it { should serialize_to git: { submodules_depth: 10 } }
      it { should_not have_msg }
    end

    describe 'strategy' do
      describe 'clone' do
        yaml %(
          git:
            strategy: clone
        )
        let(:value) { { git: { strategy: 'clone' } } }
        it { should serialize_to git: { strategy: 'clone' } }
        it { should_not have_msg }
      end

      describe 'tarball' do
        yaml %(
          git:
            strategy: tarball
        )
        it { should serialize_to git: { strategy: 'tarball' } }
        it { should_not have_msg }
      end

      describe 'unknown' do
        yaml %(
          git:
            strategy: unknown
        )
        it { should serialize_to git: { strategy: 'unknown' } }
        it { should have_msg [:error, :'git.strategy', :unknown_value, value: 'unknown'] }
      end
    end

    describe 'autocrlf' do
      describe 'true' do
        yaml %(
          git:
            autocrlf: true
        )
        let(:value) { { git: { autocrlf: true } } }
        it { should serialize_to git: { autocrlf: true } }
        it { should_not have_msg }
      end

      describe 'false' do
        yaml %(
          git:
            autocrlf: false
        )
        let(:value) { { git: { autocrlf: false } } }
        it { should serialize_to git: { autocrlf: false } }
        it { should_not have_msg }
      end

      describe 'input' do
        yaml %(
          git:
            autocrlf: input
        )
        let(:value) { { git: { autocrlf: 'input' } } }
        it { should serialize_to git: { autocrlf: 'input' } }
        it { should_not have_msg }
      end

      describe 'invalid' do
        yaml %(
          git:
            autocrlf: invalid
        )
        let(:value) { { git: { autocrlf: 'invalid' } } }
        it { should serialize_to git: { autocrlf: 'invalid' } }
        it { should have_msg [:error, :'git.autocrlf', :unknown_value, value: 'invalid'] }
      end
    end
  end
end

describe Travis::Yml do
  accept 'branches' do
    describe 'given a bool' do
      yaml %(
        branches: true
      )
      it { should serialize_to branches: { only: ['true'] } }
      it { should_not have_msg }
    end

    describe 'given a string' do
      yaml %(
        branches: master
      )
      it { should serialize_to branches: { only: ['master'] } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        branches:
        - master
      )
      let(:value) { { branches: [only: 'master'] } }
      it { should serialize_to branches: { only: ['master'] } }
      it { should_not have_msg }
    end

    describe 'given a typo on the key' do
      yaml %(
        barnches: master
      )
      it { should serialize_to branches: { only: ['master'] } }
      it { should have_msg [:warn, :root, :find_key, original: 'barnches', key: 'branches'] }
    end

    describe 'only' do
      describe 'given a string' do
        yaml %(
          branches:
            only: master
        )
        it { should serialize_to branches: { only: ['master'] } }
        it { should_not have_msg }
      end

      describe 'given a seq' do
        yaml %(
          branches:
            only:
            - master
        )
        it { should serialize_to branches: { only: ['master'] } }
        it { should_not have_msg }
      end

      describe 'given a seq of hashes' do
        yaml %(
          branches:
          - only: master
        )
        it { should serialize_to branches: { only: ['master'] } }
        it { should have_msg [:warn, :branches, :unexpected_seq, value: { only: 'master' }] }
      end

      describe 'given a typo on the key' do
        yaml %(
          barnches:
            olny: master
        )
        it { should serialize_to branches: { only: ['master'] } }
        it { should have_msg [:warn, :branches, :find_key, original: 'olny', key: 'only'] }
      end
    end

    describe 'except' do
      describe 'given a string' do
        yaml %(
          branches:
            except: master
        )
        it { should serialize_to branches: { except: ['master'] } }
        it { should_not have_msg }
      end

      describe 'given a seq' do
        yaml %(
          branches:
            except:
            - master
        )
        it { should serialize_to branches: { except: ['master'] } }
        it { should_not have_msg }
      end

      describe 'given a seq of hashes' do
        yaml %(
          branches:
            - except: master
        )
        it { should serialize_to branches: { except: ['master'] } }
        it { should have_msg [:warn, :branches, :unexpected_seq, value: { except: 'master' }] }
      end
    end

    describe 'exclude (alias)' do
      yaml %(
        branches:
          exclude: master
      )
      it { should serialize_to branches: { except: ['master'] } }
      it { should have_msg [:info, :branches, :alias_key, alias: 'exclude', key: 'except'] }
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
end

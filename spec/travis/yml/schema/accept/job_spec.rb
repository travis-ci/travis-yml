describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  stages = %i(
    before_install
    install
    after_install
    before_script
    script
    after_script
    after_result
    after_success
    after_failure
    before_deploy
    after_deploy
    before_cache
  )

  describe 'job' do
    it { should validate if: 'branch = master' }
    it { should validate osx_image: 'image' }
    it { should validate source_key: 'key' }

    stages.each do |stage|
      it { should validate stage => './script' }
      it { should validate stage => ['./script'] }
      it { should_not validate stage => { script: './script' } }
      it { should_not validate stage => [ script: './script' ] }
    end
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'job' do
          it { should validate matrix => { key => { if: 'branch = master' } } }
          it { should validate matrix => { key => { osx_image: 'image' } } }
          it { should validate matrix => { key => { source_key: 'key' } } }

          it { should validate matrix => { key => { script: './script' } } }
          it { should validate matrix => { key => { script: ['./script'] } } }
          xit { should_not validate matrix => { key => { script: { script: './script' } } } }
          xit { should_not validate matrix => { key => { script: [ script: './script' ] } } }
        end

        describe 'jobs' do
          it { should validate matrix => { key => [ if: 'branch = master' ] } }
          it { should validate matrix => { key => [ osx_image: 'image' ] } }
          it { should validate matrix => { key => [ source_key: 'key' ] } }

          it { should validate matrix => { key => [ script: './script' ] } }
          it { should validate matrix => { key => [ script: ['./script'] ] } }
          xit { should_not validate matrix => { key => [ script: { script: './script' } ] } }
          xit { should_not validate matrix => { key => [ script: [ script: './script' ] ] } }
        end
      end
    end
  end
end

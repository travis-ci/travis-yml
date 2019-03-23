describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'language' do
    it { should validate language: 'ruby' }
    it { should validate language: 'shell' }

    it { should_not validate language: 'not-a-language' }
    it { should_not validate language: ['ruby'] }
    it { should_not validate language: [name: 'ruby'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'language (on a hash)' do
          it { should validate matrix => { key => { language: 'ruby' } } }
          it { should_not validate matrix => { key => { language: 'not-a-language' } } }
        end

        describe 'language (on an array of hashes)' do
          it { should validate matrix => { key => [language: 'ruby'] } }
          it { should_not validate matrix => { key => [language: 'not-a-language'] } }
        end
      end
    end
  end
end

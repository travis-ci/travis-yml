describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'vm' do
    it { should validate vm: { size: 'medium' } }
    it { should validate vm: { size: '2x-large' } }
    it { should_not validate vm: { size: '3x-large' } }
    it { should_not validate vm: { size: ['medium'] } }
    it { should_not validate vm: { size: { name: 'medium' } } }

  end

  describe 'matrix' do
    %i(matrix).each do |matrix|
      %i(include exclude).each do |key|
        describe 'env (on a hash)' do
          it { should validate matrix => { key => { vm: { size: 'medium' } } } }
          xit { should_not validate matrix => { key => { vm: { size: '4x-large' } } } }
        end

        describe 'env (on an array of hashes)' do
          it { should validate matrix => { key => [vm: { size: 'large' }] } }
          xit { should_not validate matrix => { key => [vm: { size: '1x-large' }] } }
        end
      end
    end
  end
end

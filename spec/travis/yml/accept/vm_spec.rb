describe Travis::Yml do
  accept 'vm' do

    describe 'size' do
      describe 'medium' do
        yaml %(
          vm:
            size: medium
        )
        let(:value) { { vm: { size: 'medium' } } }
        it { should serialize_to vm: { size: 'medium' } }
        it { should_not have_msg }
      end

      describe 'large' do
        yaml %(
          vm:
            size: large
        )
        let(:value) { { vm: { size: 'large' } } }
        it { should serialize_to vm: { size: 'large' } }
        it { should_not have_msg }
      end

      describe 'x-large' do
        yaml %(
          vm:
            size: x-large
        )
        let(:value) { { vm: { size: 'x-large' } } }
        it { should serialize_to vm: { size: 'x-large' } }
        it { should_not have_msg }
      end

      describe '2x-large' do
        yaml %(
          vm:
            size: 2x-large
        )
        let(:value) { { vm: { size: '2x-large' } } }
        it { should serialize_to vm: { size: '2x-large' } }
        it { should_not have_msg }
      end
    end
  end
end

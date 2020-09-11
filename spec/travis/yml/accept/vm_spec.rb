describe Travis::Yml do
  accept 'vm' do
    describe 'no default' do
      yaml ''
      it { should serialize_to empty }
    end

    known = %w(
      medium
      large
      x-large
      2x-large
    )

    known.each do |value|
      describe "given size #{value}" do
        yaml %(
          vm:
            size: #{value}
             )
        it { should serialize_to vm: {size: value} }
        it { should_not have_msg }
      end
    end
  end
end
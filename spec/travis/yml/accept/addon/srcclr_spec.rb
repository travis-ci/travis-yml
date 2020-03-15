describe Travis::Yml do
  accept 'addon: srcclr' do
    describe 'given true' do
      yaml %(
        addons:
          srcclr: true
      )
      it { should serialize_to addons: { srcclr: true } }
      it { should_not have_msg }
    end

    describe 'given a str', drop: true do
      yaml %(
        addons:
          srcclr: str
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'addons.srcclr', :invalid_type, expected: :map, actual: :str, value: 'str'] }
    end

    describe 'given a seq', drop: true do
      yaml %(
        addons:
          srcclr:
          - str
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'addons.srcclr', :invalid_type, expected: :map, actual: :seq, value: ['str']] }
    end

    describe 'given a map' do
      yaml %(
        addons:
          srcclr:
            foo: str
      )
      it { should serialize_to addons: { srcclr: { foo: 'str' } } }
      it { should_not have_msg }
    end
  end
end

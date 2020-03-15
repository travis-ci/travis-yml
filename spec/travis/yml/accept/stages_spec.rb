describe Travis::Yml do
  accept 'stages' do
    describe 'given a str' do
      yaml %(
        stages: one
      )
      it { should serialize_to stages: [name: 'one'] }
    end

    describe 'given a seq of strs' do
      yaml %(
        stages:
        - one
      )
      it { should serialize_to stages: [name: 'one'] }
    end

    describe 'given a seq of maps' do
      yaml %(
        stages:
        - name: one
          if: 'branch = master'
      )
      it { should serialize_to stages: [name: 'one', if: 'branch = master'] }
    end
  end
end

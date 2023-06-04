describe Travis::Yml do
  accept 'addon: jwts' do
    describe 'given a str' do
      yaml %(
        addons:
          jwt: foo
      )
      it { should serialize_to addons: { jwt: ['foo'] } }
      it { should have_msg [:info, :addons, :deprecated_key, key: 'jwt', info: 'Discontinued as of April 17, 2018'] }
    end

    describe 'given a secure' do
      yaml %(
        addons:
          jwt:
            secure: #{secure}
      )
      it { should serialize_to addons: { jwt: [secure: secure] } }
    end

    describe 'given a seq of strs' do
      yaml %(
        addons:
          jwt:
          - foo
      )
      it { should serialize_to addons: { jwt: ['foo'] } }
    end

    describe 'given a seq of secures' do
      yaml %(
        addons:
          jwt:
          - secure: #{secure}
      )
      it { should serialize_to addons: { jwt: [secure: secure] } }
    end
  end
end

describe Travis::Yml do
  accept 'addons' do
    describe 'drops an unknown addon' do
      yaml %(
        addons:
          unknown:
            foo: bar
      )
      it { should serialize_to addons: { unknown: { foo: 'bar' } } }
      it { should have_msg [:warn, :addons, :unknown_key, key: 'unknown', value: { foo: 'bar' }] }
    end
  end
end

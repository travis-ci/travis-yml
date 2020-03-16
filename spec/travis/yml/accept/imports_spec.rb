describe Travis::Yml do
  accept 'imports' do
    describe 'given a non-ref' do
      yaml %(
        import: not-a-ref
      )

      with context: :yml do
        it { should serialize_to import: [source: 'not-a-ref'] }
        it { should_not have_msg }
      end

      with context: :configs do
        it { should serialize_to import: [source: 'not-a-ref'] }
        it { should have_msg [:error, :import, :invalid_ref, ref: 'not-a-ref'] }
      end
    end
  end

  subject { described_class.load(yaml, opts) }

  describe 'given a ref' do
    yaml %(
      import: ./ruby.yml
    )
    it { should serialize_to import: [source: './ruby.yml'] }
    it { should_not have_msg }
  end

  describe 'given a seq of refs' do
    yaml %(
      import:
      - ./ruby.yml
    )
    it { should serialize_to import: [source: './ruby.yml'] }
    it { should_not have_msg }
  end

  describe 'given a map' do
    yaml %(
      import:
        source: ./ruby.yml
    )
    it { should serialize_to import: [source: './ruby.yml'] }
    it { should_not have_msg }
  end

  describe 'given a seq of maps' do
    yaml %(
      import:
      - source: ./ruby.yml
        mode: merge
    )
    it { should serialize_to import: [source: './ruby.yml', mode: 'merge'] }
    it { should_not have_msg }
  end
end

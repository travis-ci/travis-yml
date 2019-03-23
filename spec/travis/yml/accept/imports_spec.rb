describe Travis::Yml, 'imports' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a string' do
    yaml %(
      import: ./ruby.yml
    )
    it { should serialize_to import: [source: './ruby.yml'] }
  end

  describe 'given a seq of strings' do
    yaml %(
      import:
      - ./ruby.yml
    )
    it { should serialize_to import: [source: './ruby.yml'] }
  end

  describe 'given a map' do
    yaml %(
      import:
        source: ./ruby.yml
    )
    it { should serialize_to import: [source: './ruby.yml'] }
  end

  describe 'given a seq of maps' do
    yaml %(
      import:
      - source: ./ruby.yml
        mode: merge
    )
    it { should serialize_to import: [source: './ruby.yml', mode: 'merge'] }
  end
end

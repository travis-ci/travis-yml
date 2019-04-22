describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'import' do
    it { should validate import: 'one.yml' }
    it { should validate import: ['one.yml', 'two.yml'] }
    it { should validate import: { source: 'one.yml', mode: :merge } }
    it { should validate import: [source: 'one.yml', mode: :merge] }

    it { should_not validate import: [foo: :merge] }
  end
end

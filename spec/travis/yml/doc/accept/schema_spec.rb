describe Travis::Yml::Doc::Schema do
  let(:schema) { Travis::Yml.expand }

  matcher :have_key do |key|
    match { |node| node.key == key }
  end

  matcher :have_values do |*values|
    match { |node| values.all? { |value| node.known?(value) } }
  end

  matcher :have_type do |type|
    match { |seq| seq.types.all?(&:"#{type}?") }
  end

  describe 'language' do
    subject { schema['language'] }
    it { should be_enum }
    it { should have_values 'ruby', 'shell' }
  end

  describe 'env' do
    subject { schema['env'] }
    it { should be_any }
  end

  describe 'aliases' do
    subject { schema.aliases }
    it { should include 'jobs' => 'matrix' }
  end

  # describe 'env.matrix' do
  #   subject { schema[:env][0][:matrix][0].schema } #[0][0] }
  #   it { should be_map }
  #   it { should_not be_strict }
  # end
  #
  # describe 'import' do
  #   subject { schema[:import][0][0][0] }
  #   it { should be_map }
  #   it { should be_strict }
  # end
end

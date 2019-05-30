# describe Travis::Yml::Schema::Type::Lang do
#   # let(:language) { Travis::Yml::Schema::Type::Language.new }
#   #
#   # let(:ruby) do
#   #   Class.new(described_class) do
#   #     register :ruby
#   #
#   #     def self.define
#   #       title 'ruby'
#   #       # matrix :rvm, alias: [:ruby, :rbenv]
#   #       # map :bundler_args, to: :str
#   #     end
#   #   end
#   # end
#   #
#   # before { ruby.before_define }
#   # before { ruby.define }
#   #
#   # subject { ruby.new }
#   #
#   # it { should have_opt title: 'ruby' }
#   # it { expect(language).to have_opt enum: [:ruby] }
#   # # it { should have_opt detect: :provider }
#   # # it { expect(subject.types.map(&:class)).to eq [other] }
#
#   let(:language) { Travis::Yml::Schema::Type::Language.new }
#   let(:android)  { Travis::Yml::Schema::Def::Android::Support.new }
#   let(:cpp)  { Travis::Yml::Schema::Def::Cpp.new }
#
#   before(:all) { Travis::Yml::Schema::Def.define }
#   it { p language }
#   # it { p android[:jdk] }
#   it { p cpp }
# end

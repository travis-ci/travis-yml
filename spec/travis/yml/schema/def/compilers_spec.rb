describe Travis::Yml::Schema::Def::Compilers, 'structure' do
  describe 'definitions' do
    describe 'compilers' do
      subject { Travis::Yml.schema[:definitions][:type][:compilers] }

      # it { puts JSON.pretty_generate(subject[:compilers]) }

      it do
        should eq(
          '$id': :compilers,
          title: 'Compilers',
          '$ref': '#/definitions/strs'
        )
      end
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/type/compilers'
  #     )
  #   end
  # end
end

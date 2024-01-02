describe Travis::Yml::Schema::Def::Workspaces do
  describe 'workspaces' do
    subject { Travis::Yml.schema[:definitions][:type][:workspaces] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
               '$id': :workspaces,
               title: 'Workspaces',
               summary: kind_of(String),
               description: kind_of(String),
               see: {
                 Workspaces: kind_of(String)
               },
               normal: true,
               properties: {
                 create: {
                   additionalProperties: false,
                   normal: true,
                   properties:{
                     name: {
                       flags: [:unique],
                       type: :string
                     },
                     paths: {'$ref': "#/definitions/type/strs"}
                   },
                   type: :object
                 },
                 use:{
                   '$ref': "#/definitions/type/strs",
                   flags: [:unique]
                 }
               }
             )
    end
  end
end
describe Travis::Yml do
  accept 'workspaces' do
    describe 'create' do
      yaml %(
        workspaces:
          create:
           name : ws1
           paths: bin/
      )
      it { should serialize_to workspaces: { create: { name: 'ws1', paths: ['bin/']}} }
    end

    describe 'given a seq of workspaces to use' do
      yaml %(
        workspaces:
          use:
          - ws1
          - ws2
      )
      it { should serialize_to workspaces: {use: ['ws1', 'ws2'] } }
    end

    describe 'given a single workspace to use' do
      yaml %(
        workspaces:
         use : ws1
      )
      it { should serialize_to workspaces: {use: ['ws1'] } }
    end
  end
end

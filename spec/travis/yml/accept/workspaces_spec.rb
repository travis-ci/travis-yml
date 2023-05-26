describe Travis::Yml do
  accept 'workspaces' do
    describe 'given a str' do
      yaml %(
        workspaces: ws1
      )
      it { should serialize_to workspaces: [name: 'ws1'] }
    end

    describe 'given a map' do
      yaml %(
        workspaces:
          name: ws1
      )
      it { should serialize_to workspaces: [name: 'ws1'] }
    end

    describe 'given a seq of strs' do
      yaml %(
        workspaces:
        - ws1
      )
      it { should serialize_to workspaces: [name: 'ws1'] }
    end

    describe 'given a seq of maps' do
      yaml %(
        workspaces:
        - name: ws1
          create: true
      )
      it { should serialize_to workspaces: [name: 'ws1', create: true] }
    end
  end
end

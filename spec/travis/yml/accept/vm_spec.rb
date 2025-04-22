describe Travis::Yml do
  accept 'vm' do

    describe 'size' do
      describe 'medium' do
        yaml %(
          vm:
            size: medium
        )
        let(:value) { { vm: { size: 'medium' } } }
        it { should serialize_to vm: { size: 'medium' } }
        it { should_not have_msg }
      end

      describe 'large' do
        yaml %(
          vm:
            size: large
        )
        let(:value) { { vm: { size: 'large' } } }
        it { should serialize_to vm: { size: 'large' } }
        it { should_not have_msg }
      end

      describe 'x-large' do
        yaml %(
          vm:
            size: x-large
        )
        let(:value) { { vm: { size: 'x-large' } } }
        it { should serialize_to vm: { size: 'x-large' } }
        it { should_not have_msg }
      end

      describe '2x-large' do
        yaml %(
          vm:
            size: 2x-large
        )
        let(:value) { { vm: { size: '2x-large' } } }
        it { should serialize_to vm: { size: '2x-large' } }
        it { should_not have_msg }
      end
    end

    describe 'create' do
      describe 'name' do
        describe 'my_custom_name' do
        yaml %(
          vm:
            create:
              name: my_custom_name
        )
        let(:value) { { vm: { create: { name: 'my_custom_name' } } } }
        it { should serialize_to vm: { create: { name: 'my_custom_name' } } }
        it { should_not have_msg }
        end
      end
    end

    describe 'create' do
      describe 'name' do
        describe 'my_custom_name_duplicate' do
          yaml %(
            jobs:
              include:
                - os: linux
                  dist: focal
                  vm:
                    create:
                      name: my_custom_name_duplicate
                - os: linux
                  dist: focal
                  vm:
                    create:
                      name: my_custom_name_duplicate
          )
          it { should have_msg [:error, :"jobs.include.vm.create", :duplicate, { :values => [ "my_custom_name_duplicate" ] } ] }
        end
      end
    end

     describe 'use' do
      describe 'name' do
        describe 'my_custom_name' do
        yaml %(
          vm:
            use:
              name: my_custom_name
        )
        let(:value) { { vm: { use: { name: 'my_custom_name' } } } }
        it { should serialize_to vm: { use: { name: 'my_custom_name' } } }
        it { should_not have_msg }
        end
      end
    end
  end
end

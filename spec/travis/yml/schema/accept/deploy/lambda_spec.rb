# describe Travis::Yml::Schema, 'accept deploy', slow: true do
#   subject { described_class.schema }
#
#   xit { puts JSON.pretty_generate(subject[:definitions][:lambda]) }
#
#   describe 'lambda' do
#     describe 'access_key_id' do
#       it { should validate deploy: { provider: :lambda, access_key_id: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, access_key_id: 1 } }
#       it { should_not validate deploy: { provider: :lambda, access_key_id: true } }
#       it { should_not validate deploy: { provider: :lambda, access_key_id: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, access_key_id: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, access_key_id: [{:foo=>'foo'}] } }
#     end
#
#     describe 'secret_access_key' do
#       it { should validate deploy: { provider: :lambda, secret_access_key: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, secret_access_key: 1 } }
#       it { should_not validate deploy: { provider: :lambda, secret_access_key: true } }
#       it { should_not validate deploy: { provider: :lambda, secret_access_key: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, secret_access_key: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, secret_access_key: [{:foo=>'foo'}] } }
#     end
#
#     describe 'region' do
#       it { should validate deploy: { provider: :lambda, region: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, region: 1 } }
#       it { should_not validate deploy: { provider: :lambda, region: true } }
#       it { should_not validate deploy: { provider: :lambda, region: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, region: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, region: [{:foo=>'foo'}] } }
#     end
#
#     describe 'function_name' do
#       it { should validate deploy: { provider: :lambda, function_name: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, function_name: 1 } }
#       it { should_not validate deploy: { provider: :lambda, function_name: true } }
#       it { should_not validate deploy: { provider: :lambda, function_name: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, function_name: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, function_name: [{:foo=>'foo'}] } }
#     end
#
#     describe 'role' do
#       it { should validate deploy: { provider: :lambda, role: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, role: 1 } }
#       it { should_not validate deploy: { provider: :lambda, role: true } }
#       it { should_not validate deploy: { provider: :lambda, role: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, role: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, role: [{:foo=>'foo'}] } }
#     end
#
#     describe 'handler_name' do
#       it { should validate deploy: { provider: :lambda, handler_name: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, handler_name: 1 } }
#       it { should_not validate deploy: { provider: :lambda, handler_name: true } }
#       it { should_not validate deploy: { provider: :lambda, handler_name: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, handler_name: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, handler_name: [{:foo=>'foo'}] } }
#     end
#
#     describe 'module_name' do
#       it { should validate deploy: { provider: :lambda, module_name: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, module_name: 1 } }
#       it { should_not validate deploy: { provider: :lambda, module_name: true } }
#       it { should_not validate deploy: { provider: :lambda, module_name: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, module_name: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, module_name: [{:foo=>'foo'}] } }
#     end
#
#     describe 'zip' do
#       it { should validate deploy: { provider: :lambda, zip: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, zip: 1 } }
#       it { should_not validate deploy: { provider: :lambda, zip: true } }
#       it { should_not validate deploy: { provider: :lambda, zip: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, zip: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, zip: [{:foo=>'foo'}] } }
#     end
#
#     describe 'description' do
#       it { should validate deploy: { provider: :lambda, description: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, description: 1 } }
#       it { should_not validate deploy: { provider: :lambda, description: true } }
#       it { should_not validate deploy: { provider: :lambda, description: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, description: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, description: [{:foo=>'foo'}] } }
#     end
#
#     describe 'timeout' do
#       it { should validate deploy: { provider: :lambda, timeout: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, timeout: 1 } }
#       it { should_not validate deploy: { provider: :lambda, timeout: true } }
#       it { should_not validate deploy: { provider: :lambda, timeout: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, timeout: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, timeout: [{:foo=>'foo'}] } }
#     end
#
#     describe 'memory_size' do
#       it { should validate deploy: { provider: :lambda, memory_size: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, memory_size: 1 } }
#       it { should_not validate deploy: { provider: :lambda, memory_size: true } }
#       it { should_not validate deploy: { provider: :lambda, memory_size: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, memory_size: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, memory_size: [{:foo=>'foo'}] } }
#     end
#
#     describe 'runtime' do
#       it { should validate deploy: { provider: :lambda, runtime: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, runtime: 1 } }
#       it { should_not validate deploy: { provider: :lambda, runtime: true } }
#       it { should_not validate deploy: { provider: :lambda, runtime: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, runtime: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, runtime: [{:foo=>'foo'}] } }
#     end
#
#     describe 'environment_variables' do
#       it { should validate deploy: { provider: :lambda, environment_variables: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, environment_variables: 1 } }
#       it { should_not validate deploy: { provider: :lambda, environment_variables: true } }
#       it { should_not validate deploy: { provider: :lambda, environment_variables: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, environment_variables: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, environment_variables: [{:foo=>'foo'}] } }
#     end
#
#     describe 'security_group_ids' do
#       it { should validate deploy: { provider: :lambda, security_group_ids: 'str' } }
#       it { should validate deploy: { provider: :lambda, security_group_ids: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, security_group_ids: 1 } }
#       it { should_not validate deploy: { provider: :lambda, security_group_ids: true } }
#       it { should_not validate deploy: { provider: :lambda, security_group_ids: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, security_group_ids: [{:foo=>'foo'}] } }
#     end
#
#     describe 'subnet_ids' do
#       it { should validate deploy: { provider: :lambda, subnet_ids: 'str' } }
#       it { should validate deploy: { provider: :lambda, subnet_ids: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, subnet_ids: 1 } }
#       it { should_not validate deploy: { provider: :lambda, subnet_ids: true } }
#       it { should_not validate deploy: { provider: :lambda, subnet_ids: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, subnet_ids: [{:foo=>'foo'}] } }
#     end
#
#     describe 'dead_letter_config' do
#       it { should validate deploy: { provider: :lambda, dead_letter_config: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, dead_letter_config: 1 } }
#       it { should_not validate deploy: { provider: :lambda, dead_letter_config: true } }
#       it { should_not validate deploy: { provider: :lambda, dead_letter_config: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, dead_letter_config: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, dead_letter_config: [{:foo=>'foo'}] } }
#     end
#
#     describe 'kms_key_arn' do
#       it { should validate deploy: { provider: :lambda, kms_key_arn: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, kms_key_arn: 1 } }
#       it { should_not validate deploy: { provider: :lambda, kms_key_arn: true } }
#       it { should_not validate deploy: { provider: :lambda, kms_key_arn: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, kms_key_arn: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, kms_key_arn: [{:foo=>'foo'}] } }
#     end
#
#     describe 'tracing_mode' do
#       it { should validate deploy: { provider: :lambda, tracing_mode: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, tracing_mode: 1 } }
#       it { should_not validate deploy: { provider: :lambda, tracing_mode: true } }
#       it { should_not validate deploy: { provider: :lambda, tracing_mode: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, tracing_mode: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, tracing_mode: [{:foo=>'foo'}] } }
#     end
#
#     describe 'publish' do
#       it { should validate deploy: { provider: :lambda, publish: true } }
#       it { should_not validate deploy: { provider: :lambda, publish: 1 } }
#       it { should_not validate deploy: { provider: :lambda, publish: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, publish: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, publish: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, publish: [{:foo=>'foo'}] } }
#     end
#
#     describe 'function_tags' do
#       it { should validate deploy: { provider: :lambda, function_tags: 'str' } }
#       it { should_not validate deploy: { provider: :lambda, function_tags: 1 } }
#       it { should_not validate deploy: { provider: :lambda, function_tags: true } }
#       it { should_not validate deploy: { provider: :lambda, function_tags: ['str'] } }
#       it { should_not validate deploy: { provider: :lambda, function_tags: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :lambda, function_tags: [{:foo=>'foo'}] } }
#     end
#   end
# end

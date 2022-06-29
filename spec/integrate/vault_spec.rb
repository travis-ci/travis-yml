require 'fileutils'
require 'yaml'

describe Travis::Yml, integration_configs: true do
  context "when vault has secure token and it is a root level" do
    let(:yaml) { File.read('spec/fixtures/vault_configs/root_valid_scenario.yml') }

    it do
      config = described_class.load(yaml, alert: true, fix: true)
      expect(config.msgs).to eq([])
    end
  end

  describe 'invalid yaml' do
    context 'some fields are invalid/missing' do
      let(:yaml) do
        <<-eos
vault:
  token: "GlDMtsM4IfjMF0N3+B8Y6suuxXtlirXtILEEWT2ZPKlFd4AeHDj2PzGR57wu13svIEdzyc9iq2zVOssRI3KS/iucnwbl16pRmr+n5A1bjfvKCeyVkHkSJjCKEDWpCTbRJT7Y+wbHnMsQoyWGxH9AXQneaeYtjBLpWcolRInJsYxx70rP2PaB/GRLY06fDnFcMI/IsTD72phEJOZ7FUs80js5ljLVUzW+NvROAz9KUw4/Yb5PJ/2kBgC5/JCg+RlbQ335buwrM+vOgVR3uXPCNj9Gb3DvSlUxsNJ1POO1YkShMrwZNtzwjNtgXBK+xuYn4RqjsbRthZAwOfTZ/dZaVBfVgrFEDIs2feJvZly93d+pYNbLSq5r21zE9856/jQGkQiPW8xpi8MEbzfscXwun0mvQ+SpSYOFoju/2eqXp7N+YH9UkT5AVSU9sQclwv4FOYw42NnXCu/4FQ/Qo7cbpwPPBhR5IUWBPmB+vbMBGsoWCgS5F9nzfNIJBV/U7rpw23TUlNbb6X3msVSPRaKK8tWphYij4br5J+V3dW0hg+otILSI52eRVQdHfnv8zxUNWDgaYUGPIrSdDaq2KrJNzr2oxXESzS6rx8HuIn28eh1e4VRXHDHO1EgrYnlXhnz2258hCuToc2IKTOTNBEvoAPvQLCeWzL2LdkUOHIQ5MFE="
  secrets:
    - kv_api_ver: invalid_value
    - namespace:
        - random_key: ns1
        - project_id/secret_key
        - project_id/secret_key2
    - namespace:
        - name: ns2
        - project_id2/secret_key
        - project_id2/secret_key2
    - ns1/project_id/secret_key
    - ns1/project_id/secret_key2
    - ns2/project_id/secret_key
    - ns2/project_id/secret_key2
        eos
      end

      it do
        config = described_class.load(yaml, alert: true, fix: true, defaults: true)
        expect(config.msgs).to match_array([[:info, :root, :default, { :default => "ruby", :key => "language" }],
                                            [:info, :root, :default, { :default => "linux", :key => "os" }],
                                            [:info, :root, :default, { :default => "xenial", :key => "dist" }],
                                            [:alert, :"vault.token", :secure, { :type => :str }],
                                            [:error,
                                             :"vault.secrets.kv_api_ver",
                                             :unknown_value,
                                             { :value => "invalid_value" }],
                                            [:error,
                                             :"vault.secrets",
                                             :invalid_type,
                                             { :actual => :map,
                                               :expected => :str,
                                               :value =>
                                                 { :namespace =>
                                                     [{ :random_key => "ns1" },
                                                      "project_id/secret_key",
                                                      "project_id/secret_key2"] } }],
                                            [:error, :vault, :required, { :key => "api_url" }]])
      end
    end
  end
end
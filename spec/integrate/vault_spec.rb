# frozen_string_literal: true

require 'fileutils'
require 'yaml'

describe Travis::Yml, integration_configs: true do
  context 'when config has vault key as a root level key' do
    context 'when the vault config is valid' do
      let(:yaml) { File.read('spec/fixtures/vault_configs/root_valid_scenario.yml') }

      it do
        config = described_class.load(yaml, alert: true, fix: true, defaults: true)
        expect(config.msgs).to match_array([[:info, :root, :default, { default: 'ruby', key: 'language' }],
                                            [:info, :root, :default, { default: 'linux', key: 'os' }],
                                            [:info, :root, :default, { default: 'xenial', key: 'dist' }]])
      end
    end

    context 'when the vault config is invalid' do
      let(:yaml) { File.read('spec/fixtures/vault_configs/root_invalid_scenario.yml') }

      it do
        config = described_class.load(yaml, alert: true, fix: true, defaults: true)
        expect(config.msgs).to match_array([[:info, :root, :default, { default: 'ruby', key: 'language' }],
                                            [:info, :root, :default, { default: 'linux', key: 'os' }],
                                            [:info, :root, :default, { default: 'xenial', key: 'dist' }],
                                            [:alert, :"vault.token", :secure, { type: :str }],
                                            [:error,
                                             :"vault.secrets.kv_api_ver",
                                             :unknown_value,
                                             { value: 'invalid_value' }],
                                            [:error,
                                             :"vault.secrets",
                                             :invalid_type,
                                             { actual: :map,
                                               expected: :str,
                                               value: { namespace: [{ random_key: 'ns1' },
                                                                    'project_id/secret_key',
                                                                    'project_id/secret_key2'] } }],
                                            [:error, :vault, :required, { key: 'api_url' }]])
      end
    end
  end

  context 'when has the vault key as a job level key' do
    context 'when the vault config is valid' do
      let(:yaml) { File.read('spec/fixtures/vault_configs/jobs_valid_scenario.yml') }

      it do
        config = described_class.load(yaml, alert: true, fix: true, defaults: true)
        expect(config.msgs).to match_array([[:info, :root, :default, { default: 'ruby', key: 'language' }],
                                            [:info, :root, :default, { default: 'linux', key: 'os' }],
                                            [:info, :root, :default, { default: 'xenial', key: 'dist' }]])
      end
    end

    context 'when the vault config is invalid' do
      let(:yaml) { File.read('spec/fixtures/vault_configs/jobs_invalid_scenario.yml') }

      it do
        config = described_class.load(yaml, alert: true, fix: true, defaults: true)
        expect(config.msgs).to match_array([[:info, :root, :default, { key: 'language', default: 'ruby' }],
                                            [:info, :root, :default, { key: 'os', default: 'linux' }],
                                            [:info, :root, :default, { key: 'dist', default: 'xenial' }],
                                            [:alert, :"jobs.include.vault.token", :secure, { type: :str }],
                                            [:error, :"jobs.include.vault.secrets.kv_api_ver", :unknown_value,
                                             { value: 'invalid_value' }],
                                            [:error, :"jobs.include.vault.secrets", :invalid_type,
                                             { expected: :str, actual: :map, value:
                                               { namespace:
                                                   [{ random_key: 'ns1' },
                                                    'project_id/secret_key', 'project_id/secret_key2'] } }],
                                            [:error, :"jobs.include.vault", :required, { key: 'api_url' }]])
      end
    end
  end
end

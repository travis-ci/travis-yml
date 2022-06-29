require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Vault < Type::Map
          register :vault

          def define
            map :api_url, to: :str
            map :token, to: :secure, strict: true
            map :secrets, to: :vault_secrets

            export
          end

          class VaultSecrets < Type::Seq
            register :vault_secrets

            def define
              types :str, :vault_kv_type, :vault_namespace
            end
          end

          class VaultKvType < Type::Map
            register :vault_kv_type

            def define
              map :kv_api_ver, to: :str, values: %w(kv1 kv2), downcase: true, default: 'kv2'
            end
          end

          class VaultNamespace < Type::Map
            register :vault_namespace

            def define
              map :namespace, to: :vault_namespace_record
            end
          end

          class VaultNamespaceRecord < Type::Seq
            register :vault_namespace_record

            def define
              types :str, :vault_namespace_name
            end
          end

          class VaultNamespaceName < Type::Map
            register :vault_namespace_name

            def define
              map :name, to: :str, required: true
            end
          end
        end
      end
    end
  end
end

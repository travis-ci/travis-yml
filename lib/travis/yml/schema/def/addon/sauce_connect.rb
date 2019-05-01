# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class SauceConnect < Addon
            register :sauce_connect

            def define
              change :enable

              map :enabled,             to: :bool
              map :username,            to: :secure
              map :access_key,          to: :secure
              map :direct_domains,      to: :str
              map :tunnel_domains,      to: :str
              map :no_ssl_bump_domains, to: :str

              super
            end
          end
        end
      end
    end
  end
end

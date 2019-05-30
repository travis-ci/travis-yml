# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class SauceConnect < Addon
            register :sauce_connect

            def define
              map :enabled,             to: :bool
              map :username,            to: :secure, strict: false
              map :access_key,          to: :secure
              map :direct_domains,      to: :str
              map :tunnel_domains,      to: :str
              map :no_ssl_bump_domains, to: :str
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Jwts < Dsl::Seq
            register :jwts

            def define
              title 'JSON Web Tokens'
              namespace :addon
              type :secure
              export
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Jwts < Type::Seq
            registry :addon
            register :jwts

            def define
              title 'JSON Web Tokens'
              type :secure
              export
            end
          end
        end
      end
    end
  end
end

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
              see 'JWT addon will be deprecated on April 17': 'https://blog.travis-ci.com/2018-01-23-jwt-addon-is-deprecated'
              deprecated 'Discontinued as of April 17, 2018'
              type :secure
              export
            end
          end
        end
      end
    end
  end
end

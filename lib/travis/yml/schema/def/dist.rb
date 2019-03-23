# frozen_string_literal: true
require 'travis/yml/schema/dsl/enum'

module Travis
  module Yml
    module Schema
      module Def
        class Dist < Dsl::Enum
          register :dist

          def define
            downcase

            value :trusty,        only: { os: :linux }
            value :precise,       only: { os: :linux }
            value :xenial,        only: { os: :linux }
            value :'server-2016', only: { os: :windows }, edge: true

            export
          end
        end
      end
    end
  end
end

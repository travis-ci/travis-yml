# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Dist < Type::Str
          register :dist

          def define
            title 'Distribution'
            summary 'Build environment distribution'
            see 'Virtualization environments': 'https://docs.travis-ci.com/user/reference/overview/#virtualization-environments'

            downcase

            value :trusty,        only: { os: :linux }
            value :precise,       only: { os: :linux }
            value :xenial,        only: { os: [:linux, :'linux-ppc64le'] }
            value :bionic,        only: { os: :linux }
            value :focal,         only: { os: :linux }
            value :jammy,         only: { os: :linux }
            value :'server-2016', only: { os: :windows }, edge: true
            value :rhel8,         only: { os: :linux }

            export
          end
        end
      end
    end
  end
end

# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Empty < Base
          register :empty

          def apply
            apply? && empty? ? empty : value
          end

          def apply?
            schema.seq? || schema.map?
          end

          def empty?
            !value.given?
          end

          def empty
            value.msg :warn, :empty if warn?
            blank
          end

          def warn?
            !value.errored?
          end
        end
      end
    end
  end
end

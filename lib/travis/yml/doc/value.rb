require 'travis/yml/doc/value/bool'
require 'travis/yml/doc/value/cast'
require 'travis/yml/doc/value/factory'
require 'travis/yml/doc/value/map'
require 'travis/yml/doc/value/none'
require 'travis/yml/doc/value/num'
require 'travis/yml/doc/value/secure'
require 'travis/yml/doc/value/seq'
require 'travis/yml/doc/value/str'
require 'travis/yml/doc/value/support'

module Travis
  module Yml
    module Doc
      module Value
        extend self

        def build(*args)
          Factory.build(*args)
        end
      end
    end
  end
end

require 'travis/yml/configs/configs'
require 'travis/yml/configs/errors'

module Travis
  module Yml
    module Configs
      include Errors

      def self.new(*args)
        Configs.new(*args)
      end
    end
  end
end

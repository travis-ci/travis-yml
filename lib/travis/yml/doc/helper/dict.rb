# frozen_string_literal: true
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Dict
        extend self

        PATH = 'var/keys.dict'

        def [](key)
          dict[key]
        end

        def key?(key)
          dict.key?(key)
        end

        def dict
          @dict ||= read
        end

        def read
          lines = File.read(PATH).split("\n")
          lines.map { |line| split(line) }.to_h
        end

        def split(str)
          key, _, value = str.rpartition(' ');
          [key, value]
        end

        dict
      end
    end
  end
end

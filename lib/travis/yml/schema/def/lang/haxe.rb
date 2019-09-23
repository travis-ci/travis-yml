# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Haxe < Type::Lang
          register :haxe

          def define
            title 'Haxe'
            summary 'Haxe language support'
            see 'Building a Haxe Project': 'https://docs.travis-ci.com/user/languages/haxe/'
            matrix :haxe
            map :hxml, to: :seq
            map :neko, to: :str
          end
        end
      end
    end
  end
end

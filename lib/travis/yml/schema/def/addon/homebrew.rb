# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Homebrew < Addon
            register :homebrew

            def define
              summary 'Homebrew packages to install'
              see 'Installing Packages on macOS': 'https://docs.travis-ci.com/user/installing-dependencies/#installing-packages-on-macos'

              prefix :packages

              map :update,   to: :bool
              map :packages, to: :seq
              map :casks,    to: :seq
              map :taps,     to: :seq
              map :brewfile, to: [:bool, :str]
            end
          end
        end
      end
    end
  end
end

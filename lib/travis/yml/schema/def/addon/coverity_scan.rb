# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class CoverityScan < Addon
            register :coverity_scan

            def define
              summary 'CoverityScan settings'
              see 'The Coverity Scan Addon for Travis CI': 'https://scan.coverity.com/travis_ci'

              map :project,               to: :coverity_scan_project
              map :build_script_url,      to: :str
              map :branch_pattern,        to: :str
              map :notification_email,    to: :secure, strict: false
              map :build_command,         to: :str
              map :build_command_prepend, to: :str
            end
          end

          class CoverityScanProject < Type::Map
            register :coverity_scan_project

            def define
              prefix :name

              map :name,        to: :str, required: true
              # TODO these do not seem to be used in travis-build
              map :version,     to: :str
              map :description, to: :str
            end
          end
        end
      end
    end
  end
end

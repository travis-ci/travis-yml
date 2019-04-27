# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class CoverityScan < Addon
            register :coverity_scan

            def define
              map :project, to: Project
              map :build_script_url,      to: :str
              map :branch_pattern,        to: :str
              map :notification_email,    to: :secure
              map :build_command,         to: :str
              map :build_command_prepend, to: :str
              super
            end

            class Project < Dsl::Map
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
end

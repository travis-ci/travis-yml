# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class CoverityScan < Type::Map
            register :coverity_scan

            def define
              map :project, to: :coverity_scan_project
              map :build_script_url,      to: :str
              map :branch_pattern,        to: :str
              map :notification_email,    to: :str
              map :build_command,         to: :str
              map :build_command_prepend, to: :str
            end

            class Project < Type::Map
              register :coverity_scan_project

              def define
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

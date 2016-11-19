module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class CoverityScan < Type::Map
            register :coverity_scan

            def define
              map :project, to: :coverity_scan_project
              map :build_script_url,      to: :scalar
              map :branch_pattern,        to: :scalar
              map :notification_email,    to: :scalar
              map :build_command,         to: :scalar
              map :build_command_prepend, to: :scalar
            end

            class Project < Type::Map
              register :coverity_scan_project

              def define
                map :name,        to: :scalar, required: true
                map :version,     to: :scalar
                map :description, to: :scalar
              end
            end
          end
        end
      end
    end
  end
end

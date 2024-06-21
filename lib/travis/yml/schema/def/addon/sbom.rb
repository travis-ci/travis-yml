# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Sbom < Addon
            register :sbom

            def define
              summary 'SBOM Generation'
              see 'Using SBOM generation with Travis CI': 'https://docs.travis-ci.com/'

              map :on,                  to: :sbom_conditions, alias: :true
              map :run_phase,           to: :str, default: 'after_success', values: %w(before_script script after_success after_failure)
              map :output_format,       to: :str, default: 'cyclonedx-json', values: %w(cyclonedx-json cyclonedx-xml spdx-json)
              map :output_dir,          to: :str
              map :input_dir,           to: :strs
            end
          end

          class SbomConditions < Type::Map
            register :sbom_conditions

            def define
              normal
              prefix :branch, only: :str

              map :branch,       to: :branches
              map :condition,    to: :seq, type: :str
              map :all_branches, to: :bool
              map :pr,           to: :bool
            end
          end
        end
      end
    end
  end
end

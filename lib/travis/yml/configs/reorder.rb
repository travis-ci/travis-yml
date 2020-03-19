require 'travis/yml/configs/model/job'

module Travis
  module Yml
    module Configs
      class Reorder < Struct.new(:stages, :jobs)
        include Memoize

        # Order jobs by:
        #
        #   * their stage number
        #   * their allow_failure status
        #   * their original order

        def apply
          jobs.sort_by.with_index { |job, ix| order(job, ix) }
        end

        def order(job, index)
          ix = []
          ix << names.index(job[:stage].to_s.downcase)
          ix << (job[:allow_failure] ? 1 : 0)
          ix << index
          ix.map { |ix| ix.to_s.rjust(5) }.join
        end

        def names
          stages.map { |stage| stage[:name] }.map(&:downcase)
        end
        memoize :names
      end
    end
  end
end

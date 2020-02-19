require 'travis/yml/configs/model/job'

module Travis
  module Yml
    module Configs
      class Reorder < Struct.new(:stages, :jobs)
        include Memoize

        def apply
          jobs.sort_by { |job| order(job) }
        end

        def order(job)
          [names.index(job[:stage]).to_s.rjust(5, '0'), job[:allow_failure]].join('.')
        end

        def names
          stages.map { |stage| stage[:name] }
        end
        memoize :names
      end
    end
  end
end

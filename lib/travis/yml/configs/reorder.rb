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
          ix = []
          ix << names.index(job[:stage].to_s.downcase)
          ix << job[:allow_failure]
          ix << jobs.index(job)
          ix.map { |ix| ix.to_s.rjust(5, '0') }.join('.')
        end

        def names
          stages.map { |stage| stage[:name] }.map(&:downcase)
        end
        memoize :names
      end
    end
  end
end

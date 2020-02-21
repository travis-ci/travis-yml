require 'travis/metrics'

module Travis
  module Yml
    module Helper
      module Metrics
        module ClassMethods
          def meter(method, opts = {})
            prepend Module.new {
              define_method(method) do |*args, &block|
                meter(opts[:key] || method) do
                  super(*args, &block)
                end
              end
            }
          end

          def time(method, opts = {})
            prepend Module.new {
              define_method(method) do |*args, &block|
                time(opts[:key] || method) do
                  super(*args, &block)
                end
              end
            }
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end

        def count(key)
          metrics.count(metrics_key(key))
        end

        def meter(key)
          metrics.meter(metrics_key(key))
        end

        def time(key, &block)
          metrics.time(metrics_key(key), &block)
        end

        def gauge(key, value)
          metrics.gauge(metrics_key(key), value)
        end

        private

          def metrics_key(key = nil)
            ['yml', metrics_namespace, key].compact.join('.').gsub(/[\?!]/, '').gsub(/[^\w\-\+\.]/, '')
          end

          def metrics_namespace
            self.class.name.downcase.split('::').last
          end

          def metrics
            Yml.metrics
          end
      end
    end
  end
end

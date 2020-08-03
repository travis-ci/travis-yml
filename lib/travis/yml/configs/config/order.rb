module Travis
  module Yml
    module Configs
      module Config
        class Order < Obj.new(:config)
          # make sure we keep the last duplicate, no matter in which order
          # configs have been loaded
          def run
            order_duplicates(configs.reverse)
          end

          def configs
            @configs ||= flatten(config)
          end

          def flatten(config)
            return [] if config.errored? || config.circular? || !config.matches?
            [config] + config.imports.map { |config| flatten(config) }.flatten
          end

          def order_duplicates(configs)
            configs.each.with_index do |lft, ix|
              next unless lft.skip?
              rgt = configs[(ix + 1)..-1].detect { |rgt| lft.to_s == rgt.to_s && !rgt.skip? }
              swap(lft, rgt) if rgt
            end
          end

          def swap(lft, rgt)
            lft.unskip
            rgt.skip
            lft.config, rgt.config = rgt.config, nil
          end
        end
      end
    end
  end
end

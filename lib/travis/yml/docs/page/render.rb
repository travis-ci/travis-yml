require 'erb'

module Travis
  module Yml
    module Docs
      module Page
        module Render
          def render(name = nil, opts = {})
            name ||= self.class.name.split('::').last.downcase
            scope = binding
            opts.each { |key, value| scope.local_variable_set(key, value) }
            ERB.new(tpl(name), nil, '-').result(scope)
          end

          def tpl(name)
            File.read(File.expand_path("../tpl/#{name}.erb.md", __FILE__))
          end
        end
      end
    end
  end
end

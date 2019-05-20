require 'yaml'
require 'dpl'

def stringify(hash)
  Travis::Yml::Helper::Obj.stringify(hash)
end

describe Travis::Yml, dpl: true, alert: false do
  subject { described_class.apply(parse(yaml), opts) }

  skip = %i(heroku help)
  providers = Dpl::Provider.registry.reject { |key, _| skip.include?(key) }.map(&:last)

  providers.each do |provider|
    name = provider.registry_key.to_s.split(':').first
    config = Dpl::Examples.new(provider).full_config
    config = config.merge(provider: name)

    describe provider.registry_key.to_s do
      yaml YAML.dump(stringify(deploy: [config]))
      it { should_not have_msg }
    end
  end
end

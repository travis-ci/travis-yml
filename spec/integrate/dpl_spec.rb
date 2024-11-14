require 'yaml'
require 'dpl'

def stringify(hash)
  Travis::Yml::Helper::Obj.stringify(hash)
end

describe Travis::Yml, integration_dpl: true, alert: false do
  matcher :be_known_opt do |provider|
    match do |opt|
      yaml = <<~str
        deploy:
        - provider: #{provider}
          #{opt.name}: #{value(opt)}
      str
      msgs = described_class.apply(parse(yaml), opts).msgs
      @msgs = msgs.select { |msg| msg[2] == :unknown_key }
      @msgs.empty?
    end

    def value(opt)
      if opt.flag?
        true
      elsif opt.secret?
        "\n    secure: str"
      else
        'str'
      end
    end
  end

  class HaveOpt < Struct.new(:name, :opt_name, :schema)
    SECURE  = '#/definitions/type/secure'
    SECURES = '#/definitions/type/secures'
    STRS    = '#/definitions/type/strs'

    attr_reader :reason

    def matches?
      @reason = 'not found'  unless opt
      @reason = 'not secure' if opt && opt.secret? && !secure?
      @reason = 'not a seq'  if opt && opt.array? && !seq?
      @reason = 'not a bool' if opt && opt.flag? && !bool?
      !reason
    end

    def secure?
      return true if schema.values.include?(SECURE)
      prop = schema[:anyOf]&.first&.[](:patternProperties)&.values&.first
      prop && prop.values.include?(SECURE)
    end

    def seq?
      schema.values.include?(STRS) || schema.values.include?(SECURES)
    end

    def bool?
      return true if opt.name == :edge
      schema.values.include?(:boolean)
    end

    def opt
      @opt ||= opt_names.detect { |opt| break provider.opts[opt] if provider && provider.opts[opt] }
    end

    def provider
      @provider ||= providers.detect { |provider| opt_names.any? { |opt| provider.opts[opt] } }
    end

    def providers
      Dpl::Provider.registry.select { |key, _| key.to_s.start_with?(name.to_s) }.map(&:last)
    end

    def opt_names
      [opt_name, opt_name.to_s.sub(/(no_|skip_)/, '').to_sym]
    end
  end

  matcher :have_opt do |opt, schema|
    match do |provider|
      @matcher = HaveOpt.new(provider, opt, schema)
      @matcher.matches?
    end

    failure_message do
      @matcher.reason
    end
  end

  subject { described_class.apply(parse(yaml), opts) }

  skip = %i(heroku pages help)
  providers = Dpl::Provider.registry.reject { |key, _| skip.include?(key) }.map(&:last)

  # providers.each do |provider|
  #   name = provider.registry_key.to_s.split(':').first
  #   config = Dpl::Examples.new(provider).full_config
  #   config = config.merge(provider: name)
  #
  #   filter = ->(msg) { msg[2] == :deprecated_key && msg[3][:key] == 'skip_cleanup' }
  #
  #   describe "#{provider.registry_key} example config" do
  #     yaml YAML.dump(stringify(deploy: [config])).gsub('!ruby/regexp ', '')
  #     it { should_not have_msg(&filter) }
  #   end
  #
  #   describe "#{provider.registry_key} dpl options" do
  #     provider.opts.each do |opt|
  #       next if opt.internal? || opt.name == :help
  #       it(opt.name) { expect(opt).to be_known_opt(name) }
  #     end
  #   end
  # end

  Travis::Yml.schema[:definitions][:deploy].each do |provider, schema|
    describe "#{provider} declared options" do
      skip = %i(provider on allow_failure skip_cleanup)
      next unless schema = schema[:anyOf][0][:properties]
      schema = schema.reject { |key, _| skip.include?(key) }
      schema.each do |key, schema|
        describe key.to_s do
          let(:opt) { provider.opts[key] }
          it { expect(provider).to have_opt(key, schema) }
        end
      end
    end
  end

  describe 'list of providers' do
    let(:ignore) { %i(help api git catalyze chef-supermarket) }

    let(:dpl) do
      keys = Dpl::Provider.registry.keys - ignore
      keys.map { |key| key.to_s.split(':').first.to_sym }.uniq
    end

    let(:yml) { Travis::Yml::Schema::Def::Deploy.provider_names }

    it { expect(dpl.sort).to eq yml.sort }
  end
end

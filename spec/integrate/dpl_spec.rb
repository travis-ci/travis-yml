require 'yaml'
require 'dpl'

def stringify(hash)
  Travis::Yml::Helper::Obj.stringify(hash)
end

describe Travis::Yml, dpl: true, alert: false do
  matcher :be_declared_on do |provider|
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

  subject { described_class.apply(parse(yaml), opts) }

  skip = %i(heroku pages help)
  providers = Dpl::Provider.registry.reject { |key, _| skip.include?(key) }.map(&:last)

  providers.each do |provider|
    name = provider.registry_key.to_s.split(':').first
    config = Dpl::Examples.new(provider).full_config
    config = config.merge(provider: name)

    filter = ->(msg) { msg[2] == :deprecated_key && msg[3][:key] == 'skip_cleanup' }

    describe "#{provider.registry_key.to_s} example config" do
      yaml YAML.dump(stringify(deploy: [config])).gsub('!ruby/regexp ', '')
      it { should_not have_msg(&filter) }
    end

    describe "#{provider.registry_key.to_s} options" do
      skip = %i(stage backtrace fold help)
      provider.opts.each do |opt|
        next if skip.include?(opt.name)
        it(opt.name) { expect(opt).to be_declared_on(name) }
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


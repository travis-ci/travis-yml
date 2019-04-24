require 'yaml'

def symbolize(obj)
  Travis::Yml::Helper::Obj.symbolize(obj)
end

dpls = Dir['spec/fixtures/dpl/*.yml'].sort.map do |path|
  name = path.sub('spec/fixtures/dpl/', '').sub('.yml', '')
  name = 'azure_web_apps' if name == 'AzureWebApps' # fix readme?
  [name, symbolize(YAML.load(File.read(path)))]
end

describe Travis::Yml, dpl: true do
  subject { described_class.apply(parse(yaml)) }

  def filter(msg)
    msg[2] == :underscore_key ||
    msg[2] == :unknown_value && msg[3][:value] == 'nodejitsu' || # dead provider # dead provider # dead provider # dead provider
    msg[2] == :unknown_value && msg[3][:value] == 'hephy'        # new provider? not mentioned in docs
  end

  VALUES = {
    atlas: {
      debug: true,
      vcs: true,
      version: true
    },
    bluemixcloudfoundry: {
      skip_ssl_validation: true
    },
    cloudfoundry: {
      skip_ssl_validation: true
    },
    codedeploy: {
      revision_type: 's3'
    },
    releases: {
      prerelease: true
    }
  }

  dpls.each do |provider, dpl|
    describe provider do
      dpl[:opts].each do |key, value|
        describe key.to_s do
          yaml %(
            deploy:
              - provider: #{provider}
                #{key}: #{VALUES.fetch(provider.to_sym, {})[key] || value}
          )

          it { should_not have_msg(method(:filter)) }
        end
      end
    end
  end
end

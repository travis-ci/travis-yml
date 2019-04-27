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
    msg[2] == :underscore_key # ||
    # msg[2] == :find_key && [:access_token, :local_dir, :site_id].include?(msg[3][:original])
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
      next if provider == 'hephy'      # dead provider
      next if provider == 'nodejitsu'  # new provider?

      dpl[:opts].each do |key, value|

        # the dpl readme is confused about underscored vs dasherized keys, too
        key = key.to_s.gsub('_', '-').to_sym if %i(access_token local_dir site_id).include?(key)

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

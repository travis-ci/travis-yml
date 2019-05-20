require 'yaml'

describe Travis::Yml, docs: true, alert: false do
  SKIP = [
    # ignore
    'docs_2016/deployment/006',            # example with an unknown awesome-experimental-provider
    'docs_2016/encryption-keys/008',       # strings without a = are not valid env vars any more
    'docs/deployment/010',                 # example with an unknown awesome-experimental-provider
    'docs/encryption-keys/001',            # incomplete .travis.yml (secure on root)
    'docs/encryption-keys/009',            # strings without a = are not valid env vars any more
    'docs/reference/windows/001',          # example missing language
    'docs/deployment/002',                 # using dead cloudcontrol example
    'docs/deployment/005',                 # using dead appfog example
    'docs/deployment/opsworks/007',        # using dashed option names
    'docs/deployment/chefsupermarket/001', # using dashed provider name

    # filter
    'docs/enterprise',                # not travis.yml snippets. gotta filter these using {: data-file=".travis.yml"}
    'docs/languages/r/015',
    'docs/languages/julia/002',
  ]

  LANG = {
    node_js:     'node_js',
    otp_release: 'elixir'
  }

  FILTER = {
    level: [
      :debug,
      :info
    ],
    type: [
      :deprecated # cache_enable_all seems to be documented?
    ],
    msgs: [
      [:warn, :deploy, :empty] # repeated examples for `after_deploy` scripts that have an empty deploy section
    ]
  }

  def load_config(path)
    Yaml.load(File.read(path))
  end

  def detect_lang(config)
    LANG.each { |key, lang| return lang if config.key?(key.to_s) } && nil
  end

  def filter(msg)
    FILTER[:level].include?(msg[0]) || FILTER[:type].include?(msg[2]) || FILTER[:msgs].include?(msg)
  end

  paths = Dir['spec/fixtures/docs*/**/*.yml'].sort
  paths = paths.reject { |path| SKIP.any? { |skip| path.include?(skip) } }

  let(:defaults) { { 'language' => lang } }
  let(:msgs)     { applied.msgs }

  subject { described_class.apply(defaults.merge(config), opts) }

  paths.each do |path|
    name = path.sub('spec/fixtures/docs/', '').sub('.yml', '')
    lang = path =~ %r(languages/(.+)/) && $1
    lang = 'node_js' if lang == 'javascript-with-nodejs'

    describe name do
      let(:lang)   { lang || detect_lang(config) || 'ruby' }
      let(:config) { load_config(path) }
      it { should_not have_msg(method(:filter)) }
    end
  end
end

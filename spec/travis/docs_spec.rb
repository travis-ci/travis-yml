require 'yaml'

SKIP = [
  'deployment/006',      # unknown awesome-experimental-provider
  'encryption-keys/008', # strings without a = are not valid env vars any more
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
  ]
}

def load_config(path)
  LessYAML.load(File.read(path))
end

def detect_lang(config)
  LANG.each { |key, lang| return lang if config.key?(key.to_s) } && nil
end

def filter(msg)
  FILTER[:level].include?(msg[0]) || FILTER[:type].include?(msg[2])
end

paths = Dir['spec/fixtures/docs/**/*.yml']
paths = paths.reject { |path| SKIP.any? { |skip| path.include?(skip) } }

describe Travis::Yml, docs: true do
  let(:defaults) { { language: lang } }
  let(:msgs)     { applied.msgs }

  subject { described_class.apply(defaults.merge(config)) }

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

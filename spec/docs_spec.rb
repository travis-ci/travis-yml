require 'yaml'

ENV['DOCS'] ||= 'true' if $*.join.include?(File.basename(__FILE__))

# TODO
SKIP = [
  'deployment/releases/003', # dropping section :global with mapping
  'multi-os/005'             # matrix include with python/os
]

LANG = {
  node_js:     'node_js',
  otp_release: 'elixir'
}

def load_config(path)
  YAML.load(File.read(path))
end

def detect_lang(config)
  LANG.each { |key, lang| return lang if config.key?(key.to_s) } && nil
end

describe Travis::Yaml do
  let(:msgs)     { subject.msgs.reject { |msg| msg.first == :info } }
  let(:hash)     { subject.to_h }
  let(:defaults) { { language: lang } }

  subject { described_class.apply(defaults.merge(config)) }

  def filter(msgs)
    # msgs.reject { |msg| msg[0] == :warn && msg[2] == :cast }
    msgs
  end

  paths = ENV['DOCS'] ? Dir['spec/fixtures/docs/**/*.yml'] : []

  paths.each do |path|
    next if SKIP.any? { |skip| path.include?(skip) }

    name = path.sub('spec/fixtures/docs/', '').sub('.yml', '')
    lang = path =~ %r(languages/(.+)/) && $1
    lang = 'node_js' if lang == 'javascript-with-nodejs'

    describe name do
      let(:lang)   { lang || detect_lang(config) || 'ruby' }
      let(:config) { load_config(path) }
      it { expect(filter(msgs)).to be_empty }
    end
  end
end

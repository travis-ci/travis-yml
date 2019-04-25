require 'yaml'

def symbolize(obj)
  Travis::Yml::Helper::Obj.symbolize(obj)
end

# accept:
#
#   env:
#     - COMPILER_VERSION=
#
#   env:
#     EQUATIONS=swe
#     T_ELEMENTS=line
#
#   env:
#     secure: str
#     global:
#       secure: str
#
#   notifications:
#     email:
#       - dev@abuse.io
#     skip_join: true
#
#   jobs:
#     include:
#       - stage: deploy
#
#   jobs:
#     include:
#       - script: skip

describe Travis::Yml, configs: true do
  skip = [
    '1200wd:bitcoinlib',    # windows on sh, python on sh
    '301-Redirection:DBC',  # apt on root
    'alces-software:alces-flight-center', # apt on root
    'AaltoAsia:O-MI.yml',   # flowdock api token seq
    '3343:edge',            # all sorts of msgs
    '42ity:fty-rest',       # ...
    '4dn-dcic:snovault',    # addons.apt.config.retries: true
    'AbuseIO:AbuseIO',      # misplaced skip_join (msg sucks though)
    'abilian:olapy',        # empty env var
    'abo-abo:swiper',       # language emacs-lisp
    'activeprospect:leadconduit-integrations', # wild env
    'Addepar:ember-table',  # misplaced :global
    'adriannadiaz:Axiona',  # unknown :test on :root (misplaced sucks)
    'adsabs:bumblebee',     # deployg: grunt release
    'aidantwoods:SecureHeaders', # matrix.inlcude.php expects a seq?
    'aiidateam:aiida_core', # fixme, looks all valid
    'akka:akka-management', # fixme, looks all valid
    'airbnb:knowledge-repo', # misplaced key :distributions on deploy.on
    'akumuli:Akumuli',       # misplaced key :provider on addons.artifacts
  ]

  paths = Dir['spec/fixtures/configs/**/*.yml'].sort
  paths = paths.reject { |path| skip.any? { |skip| path.include?(skip) } }
  paths = paths[0..300]

  configs = paths.map { |path| [path, File.read(path)] }

  subject { described_class.apply(parse(yaml)) }

  def filter(msg)
    msg[0] == :info ||
    msg == [:warn, :cache, :deprecated, deprecation: :cache_enable_all, value: false] ||
    msg == [:warn, :root, :find_key, original: :service, key: :services] ||

    msg[1] == :language && msg[2] == :invalid_seq ||

    msg[2] == :unknown_value && msg[3][:value] == 'bionic' ||

    msg[2] == :find_value && msg[3][:original] == '-docker' ||   # typo
    msg[2] == :find_value && msg[3][:original] == 'require' ||   # alias?

    msg[2] == :find_key && msg[3][:original] == :notification || # alias?
    msg[2] == :find_key && msg[3][:original] == :addon ||        # alias?

    msg[2] == :unsupported && msg[3][:on_value] == 'node_js' && msg[3][:key] == :jdk || # is this true?
    msg[2] == :unsupported && msg[3][:on_value] == 'cpp' && msg[3][:key] == :python || # is this true?
    msg[2] == :unsupported && msg[3][:on_value] == 'shell' && msg[3][:key] == :compiler || # is this true?

    msg[2] == :empty || # remove this?

    msg[1] == :addons && msg[2] == :invalid_seq && msg[3][:value].keys.include?(:chrome) ||

    msg[2] == :misplaced_key && msg[3][:key] == :on_start ||

    msg[2] == :deprecated && msg[3][:deprecation] == :deprecated_sonarcloud_branches ||

    false
  end

  # VALUES = {
  #   atlas: {
  #     debug: true,
  #     vcs: true,
  #     version: true
  #   },
  #   bluemixcloudfoundry: {
  #     skip_ssl_validation: true
  #   },
  #   cloudfoundry: {
  #     skip_ssl_validation: true
  #   },
  #   codedeploy: {
  #     revision_type: 's3'
  #   },
  #   releases: {
  #     prerelease: true
  #   }
  # }

  configs.each do |path, config|
    describe path.sub('spec/fixtures/configs/', '') do
      yaml config
      it { should_not have_msg(method(:filter)) }
    end
  end
end

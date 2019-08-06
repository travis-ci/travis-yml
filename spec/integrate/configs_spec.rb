require 'fileutils'
require 'yaml'

def symbolize(obj)
  Travis::Yml::Helper::Obj.symbolize(obj)
end

# accept:
#
#   # should `skip` be a generic feature? (grondo:flux-core)
#   [:error, :"matrix.include.deploy", :invalid_type, {:expected=>:map, :actual=>:str, :value=>"skip"}]

describe Travis::Yml, configs: true do
  before(:all) { FileUtils.mkdir_p('log') }
  before(:all) { FileUtils.rm_f('log/alert.log') }

  skip = [
    'andela:ah-frontend-thor',                 # addons: codeclimate (not sure if this should pass)
    'ApollosProject:apollos-prototype',        # bogus deploy.master: true (not sure if this should pass)
    'apache:incubator-openwhisk-cli',          # deploy.on.tags: $TAG (not sure if this should pass, docs are a little weird there)
    'apache:incubator-openwhisk-wskdeploy',    # deploy.on.tags: $TAG (not sure if this should pass, docs are a little weird there)
  ]

  KEYS = {
    language: %i(
      language
      matrix.include.language
    ),
    dist: %i(
      dist
      matrix.include.dist
    ),
    event: %i(
      notifications
      notifications.email
      notifications.irc
      notifications.slack
      notifications.webhooks
    ),
    os: %i(
      linux-ppc64le
      os
      matrix.include.os
      matrix.exclude.os
    ),
    stage: %i(
      root
      matrix.include
    ),
    service: %i(
      services
      matrix.include.services
    ),
    value: %i(
      notifications.email.on_failure
    )
  }

  UNKNOWN = {
    language: %w(
      common-lisp
      emacs-lisp
      general
      glsl
      kotlin
      none
      sage
      sass
      vim
    ),
    os: %w(
      android
      centos
      linux-ppc64le
    ),
    dist: %w(
      1803-containers
      bionic
      current
    ),
    service: %w(
      ~
      alsa
      docker-compose
      haveged
      ignore
      mariadb
      pgsql
      skip
      sqlite
      sqlite3
      zookeeper
    ),
    stage: %w(
      after_error
    ),
    event: [
      'on_start',         # on notifications other than webhooks
      'on_cancel',        # on notifications other than webhooks
      'on_pull_requests', # on notifications other than slack
      'on_change',
    ],
    value: %w(
      jhunt@starkandwayne.com
    )
  }

  BROKEN = {
    language: [
      'java scala node_js',
      'python - "2.7"',
      'python - "3.6"',
      'node_js - "6"',
      'node_js - "9"',
    ]
  }

  TYPOS = %w(
    -docker
    :change
    _addons
    after_acript
    alwayss
    api-key
    before_srcipt
    bundle
    chnage
    commiter-from-gh
    deployg
    derscription
    directory
    disable
    distribution
    distro
    esudo
    evn
    globale
    keep-hisotry
    langauge
    nguage
    notfications
    on_sucess
    phps
    pyton
    python2.7
    python3
    recepients
    rmv
    serivce
    ssh_know_hosts
    skip_clean
    skript
    sourcees
    sudo;
    state
    trust
    webhools
  ) << 'change  always' << 'always  always' << 'never     always'

  POTENTIAL_ALIASES = %w(
    nodejs
    require
    notification
    addon
    service
    fail_fast
    lang
    username
    add_ons
    allow_failure
    scripts
    caches
  )

  DEPRECATIONS = [
    { key: 'sudo', info: 'this key has no effect anymore' },
    { key: 'branches', info: 'not supported any more' },
    { key: 'github_token', info: 'not supported any more' },
    { key: 'skip_cleanup', info: 'not supported in dpl v2, use cleanup' },
    { value: '__sardonyx__', info: 'experimental stack language' }
  ]

  YAML_CUSTOM_CONFIG = %w(
    addons_shortcuts
    coverage
    dd
    doctr
    templates
    travisBuddy
    SECRET_KEY_BASE=593146e0067b8b14fcdcd5ebfc0b4b0e987a889f
  )

  UNKNOWN_KEYS = {
    addons: %w(
      addons
      branches
      google-chrome
      mysql
      packages
      s3_region
      services
      sonarqube
      sources
      ulimit
    ),
    'addons.apt': %w(
      cache
      chrome
      config
      coverity_scan
      packages-without-jansson
      ssh_known_hosts
    ),
    'addons.artifacts': %w(
      acl
      provider
    ),
    # is conditions on coverity_scan actually unknown?
    'addons.coverity_scan': %w(
      condition
    ),
    'addons.coverity_scan.project': %w(
      branch_pattern
      build_command
    ),
    'addons.sonarcloud': %w(
      script
    ),
    branches: %w(
      branches
      global
      submodules
    ),
    cache: %w(
      before_cache
      branches
      cache
      files
      gradle
      install
      override
      python
    ),
    deploy: %w(
      access
      after_deploy
      all_branches
      api_key
      before_deploy
      branch
      branches
      condition
      client_id
      client_secret
      deploy
      file
      file_glob
      github_commit
      github-token
      if
      local-dir
      node
      only
      options
      overwrite
      preserve-history
      repo
      script
      tags
      upload_docs
      verbose
    ),
    'deploy.on': %w(
      distributions
      branches
      java
      master
      onBranch
      prerelease
      skip-cleanup
    ),
    env: %w(
      allow_failures
      fast_finish
      general
      os
      secure
    ),
    git: %w(
      clone
      go_import_path
    ),
    # is sudo on matrix actually unknown?
    matrix: %w(
      before_install
      env
      global
      sudo
    ),
    'matrix.allow_failures': %w(
      canfail
    ),
    # should filter_secrets be valid?
    'matrix.include': %w(
      after_install
      allow_failures
      apt
      canfail
      cache.directories
      git.depth
      directories
      distribution
      fast_finish
      file
      filter_secrets
      fortran
      licenses
      notifications
      on
      only
      provider
      skip_cleanup
      version
    ),
    'matrix.include.addons': %w(
      cache
      sources
      sonarqube
    ),
    'matrix.include.addons.apt': %w(
      config
      sources
    ),
    'matrix.include.cache': %w(
      override
    ),
    # it's kinda fun that travis-ci/dpl has invalid keys on the rubygems
    # provider (script and if)
    'matrix.include.deploy': %w(
      app
      buildpack
      repo
      github_commit
      if
      overwrite
      script
    ),
    # TODO master should probably be allowed here, shouldn't it?
    'matrix.include.deploy.on': %w(
      branches
      master
      on
      script
    ),
    # notifications.if would make a ton of sense, actually
    notifications: %w(
      branches
      channels
      if
      recipients
      skip_join
      template
      urls
      use_notice
    ),
    'notifications.email': %w(
      slack
    ),
    'notifications.hipchat': %w(
      secure
    ),
    'notifications.irc': %w(
      branches
      only
      on_error
    ),
    'notifications.slack': %w(
      email
      format
      on
      secure
      slack
    ),
    'notifications.webhooks': %w(
      slack
    ),
    # is name actually unknown on root? or does it propagate to the jobs?
    root: %w(
      after_install
      after_success:before_script
      allow_failure
      allow_failures
      apt
      before-caching
      binary_packages
      build
      code_climate
      default-cflags
      deploy_docs
      deps
      directories
      edge
      email
      exclude
      except
      fast_finish
      fortran
      global
      global_env
      image
      include
      licenses
      mysql
      name
      npm
      nvm
      on
      on_failure
      on_success
      only
      postgres
      repo_token
      sbt
      secure
      serialGroup
      service_name
      slack
      sources
      stage
      sudo_required
      tags
      true
      test
      versions
      webhooks
      wttd-notifications
      yarn
    ),
    stages: %w(
      branches
    ),
  }

  INVALID_SEQS = %i(
    addons
    addons.artifacts.branch
    addons.coverity_scan.build_command
    deploy.api_key
    deploy.password
    deploy.script
    env.matrix.general
    language
    matrix.fast_finish
    matrix.allow_failures.rvm
    matrix.include.addons.apt.update
    matrix.include.addons.homebrew.update
    matrix.include.deploy.script
    matrix.include.env
    matrix.include.env.global
    matrix.include.compiler
    matrix.include.go
    matrix.include.jdk
    matrix.include.name
    matrix.include.node_js
    matrix.include.os
    matrix.include.php
    matrix.include.python
    matrix.include.rvm
    notifications
    notifications.email.on_failure
    notifications.email.on_success
    notifications.flowdock.api_token
    osx_image
    sudo
  )

  INVALID_TYPE = {
    # people often "turn off" sections in huge matrices
    bool: %i(
      matrix.include.deploy
      matrix.include.addons
      matrix.allow_failures.addons
      matrix.allow_failures.deploy
    ),
    str: %i(
      deploy
      deploy.prerelease
      deploy.on.all_branches
      matrix.include.addons
      matrix.include.deploy.prerelease
      matrix.allow_failures
    ),
    seq: %i(
      env.matrix.include
      env.matrix.general
      matrix
      matrix.include.env.global
    ),
    # on scripts this is often caused by YAML parsing a quoted string with a colon into a map
    map: %i(
      arch
      after_failure
      deploy.api_key
      deploy.env
      deploy.on.branch
      env.matrix
      matrix.include.cache.directories
      matrix.include.script
      matrix.include.after_script
      after_success
    ),
    secure: %i(
      env.matrix.DJANGO_SECRET_KEY
      env.global.github_token
    )
  }

  INVALID_CONDITIONS = [
    '(branch = dev) AND (type IS cron)' # should be type = cron
  ]

  INVALID_ENV_VARS = <<~vars.split("\n")
    TESTS="1" ODOO_REPO="OCA/OCB
    USER_LANGUAGE=en USER_REGION=US'
    USER_LANGUAGE=fr USER_REGION=FR'
    USER_LANGUAGE=ja USER_REGION=JP'
    PYTHON_VERSION=3.5 SPHINX_VERSION='1.5' SETUPTOOLS_VERSION=30 CONDA_DEPENDENCIES=`echo $CONDA_DEPENDENCIES sphinx-astropy 'numpydoc<0.9'`"
    SETUP_CMD='test' CONDA_ENVIRONMENT='conda_environment.yml' TEST_CMD="python -c $'import matplotlib\ntry:\n    import scipy\nexcept ImportError:\n    pass\nelse:\n    raise RuntimeError'"
    SETUP_CMD='test' CONDA_ENVIRONMENT='conda_environment.yml' TEST_CMD="python -c $'import matplotlib\ntry:\n    import scipy\nexcept ImportError:\n    pass\nelse:\n    raise RuntimeError'"
    SETUP_CMD='test' CONDA_ENVIRONMENT='conda_environment.yml' CONDA_DEPENDENCIES="scipy" TEST_CMD="python -c $'import matplotlib\nimport scipy'"
    DISTRIB="conda" EXAMPLES="true" PYTHON=3.7"
    APPS='[{"app":"ops","chart":"ops","namespace":"ops","deployment":"api"}]
    GIT_EARLIEST_SUPPORTED_VERSION="v2.0.0
    BUILD=stack STACK=stack --resolver=11.22'
    USER_LANGUAGE=en USER_REGION=US'
    FLEX_HOME=build-dep/bin/flex/"
    secure:"Dupdb/HgNXKu8kOo7/RcpMCAyEZA8hLw77nVPTxXUo39UUI/ipnbUfRHamiWC2/MCqTEHu+1eReCmuFj2ULk4g+vi/8VYjrmX1TiHwikIFEAGrRRK0VkuWegqloYtXuxa7gtuQ96PWjqJ48op/WYyYvKiH0cFOMHsZOt5cl9PL4="
    MAIN_CMD='flake8 count --select=F, E101, E111, E112, E113, E401, E402, E711, E722 --max-line-length=110' SETUP_CMD='gwcs"
    CI_BUILD_TARGET="sitltest-rover sitltest-sub""
    PHOEBE_ENABLE_PLOTTING = 'FALSE'
    WEBSITE_CHANGED = git diff --name-only $TRAVIS_COMMIT_RANGE | grep -E "website/|docs/"
  vars

  ENUMS = %i(
    deploy.provider
    matrix.include.deploy.provider
    notifications.hipchat.format
  )

  UNKNOWN_VALUES = [
    'grunt release',
    'skip'
  ]

  UNKNOWN_VARS = %w(
    repository_name,
  )

  def unknown?(key, msg)
    KEYS[key].include?(msg[1]) && (UNKNOWN[key].include?(msg[3][:key]) || UNKNOWN[key].include?(msg[3][:value]))
  end

  def broken?(key, msg)
    KEYS[key].include?(msg[1]) && BROKEN[key].include?(msg[3][:original])
  end

  def dist_group_expansion?(msg)
    return true if msg[1] == :dist && msg[2] == :unexpected_seq
  end

  def unsupported_dist?(msg)
    return true if msg[1] == :dist && msg[2] == :unknown_value && msg[3][:value] == 'bionic'
  end

  def typo?(msg)
    %i(clean_key clean_value find_key find_value).include?(msg[2]) && TYPOS.include?(msg[3][:original].to_s)
  end

  def potential_alias?(msg)
    %i(find_key find_value).include?(msg[2]) && POTENTIAL_ALIASES.include?(msg[3][:original].to_s) ||
    %i(unknown_key).include?(msg[2]) && POTENTIAL_ALIASES.include?(msg[3][:key].to_s)
  end

  def deprecated?(msg)
    return unless msg[2] == :deprecated_key || msg[2] == :deprecated_value
    DEPRECATIONS.include?(msg[3].reject { |key, _| key == :provider })
  end

  def yaml_anchor_key?(msg)
    msg[2] == :deprecated_key && msg[3][:info] == 'anchor on a non-private key'
  end

  # unkown keys that look like the user might parse .travis.yml during the build
  def yaml_custom_config?(msg)
    msg[2] == :unknown_key && msg[1] == :root && YAML_CUSTOM_CONFIG.include?(msg[3][:key])
  end

  def unknown_key?(msg, &block)
    return false unless msg[2] == :unknown_key && UNKNOWN_KEYS.fetch(msg[1], []).include?(msg[3][:key])
    block ? block.call : true
  end

  def questionable_env?(msg)
    return false unless msg[2] == :unknown_key && msg[1] == :matrix && msg[3][:key] == :env
    value = msg[3][:value]
    return true if value.is_a?(Hash)  && value.key?(:global)    # e.g. elmsln:elmsln
    return true if value.is_a?(Array) && value[0].is_a?(String)
  end

  def invalid_seq?(msg)
    return false unless msg[2] == :unexpected_seq
    return true if INVALID_SEQS.include?(msg[1])
    msg[1] == :notifications && msg[3][:value] == { email: false }
  end

  def invalid_type?(msg)
    return false unless msg[2] == :invalid_type
    return true if INVALID_TYPE[msg[3][:actual]]&.include?(msg[1])
    return true if msg[1] == :env && msg[3][:value].include?('global -')
    return true if msg[1] == :env && msg[3][:value].any? { |str| str.is_a?(String) && str =~ /^[^']+'$/ } # bogus single quote at the end
    return true if msg[1] == :'matrix.include.env' && msg[3][:value].key?(:matrix)
    return true if msg[1] == :'matrix.include.env' && msg[3][:value].key?(:global) # results in 'global=[{:FOO=>"foo"}]' in production https://travis-ci.org/svenfuchs/test/builds/525372730
  end

  def invalid_env_var?(msg)
    return false unless msg[2] == :invalid_env_var
    var = msg[3][:var]
    INVALID_ENV_VARS.include?(var) || var.include?('CONDA_ENVIRONMENT') || var.start_with?('==') || var.start_with?('if ')
  end

  def invalid_condition?(msg)
    msg[2] == :invalid_condition && INVALID_CONDITIONS.include?(msg[3][:condition])
  end

  def unknown_var?(msg)
    msg[2] == :unknown_var && UNKNOWN_VARS.include?(msg[3][:var])
  end

  def unsupported?(msg)
    # i think i found enough of these to know that this is probably way too spammy
    return true if msg[2] == :unsupported
  end

  def unknown_value(msg, &block)
    return false unless  msg[2] == :unknown_value
    return false unless ENUMS.include?(msg[1])
    UNKNOWN_VALUES.include?(msg[3][:value]) || block.call(msg[3][:value])
  end

  def alert?(msg)
    return unless msg[0] == :alert
    repo = path.sub(%r(spec/fixtures/configs/[^/]+/), '').sub(':', '/').sub('.yml', '')
    url = "https://github.com/#{repo}/blob/master/.travis.yml"
    File.open('log/alert.log', 'a+') { |f| f.puts("#{url} #{msg.inspect}") }
    true
  end

  def filter(msg)
    return true if msg[0] == :info
    # return true if msg[0] == :warn
    # return false

    return true if broken?(:language, msg)
    return true if unknown?(:language, msg)
    return true if unknown?(:os, msg)
    return true if unknown?(:dist, msg)
    return true if unknown?(:service, msg)
    return true if unknown?(:stage, msg)
    return true if unknown?(:event, msg)
    return true if unknown?(:value, msg)

    return true if alert?(msg)
    return true if typo?(msg)
    return true if potential_alias?(msg)
    return true if deprecated?(msg)

    return true if dist_group_expansion?(msg)  # the feature flag allowing this is off on both org and com
    return true if unsupported_dist?(msg)

    return true if unknown_value(msg) { |value| value.include?('%{repository}') } # template string on hipchat.format

    return true if yaml_anchor_key?(msg)       # people using unknown keys for storing yaml anchors
    return true if yaml_custom_config?(msg)    # people using .travis.yml as a config store that they parse at build time
    return true if questionable_env?(msg)      # should investigate these again

    return true if unknown_key?(msg)           # actually misplaced or unknown keys
    return true if invalid_seq?(msg)           # actually invalid seqs
    return true if invalid_type?(msg)          # actually invalid types
    return true if invalid_env_var?(msg)       # actually invalid env vars
    return true if invalid_condition?(msg)     # actually invalid conditions
    return true if unknown_var?(msg)           # actually invalid template vars
    return true if unsupported?(msg)

    return true if msg[1] == :language && msg[3][:value].include?('$travis_branch')

    # geoblacklight:geoblacklight (holy shit)
    return true if msg[2] == :unknown_key && msg[3][:key] == :global_env
    # grondo:flux-core
    return true if msg[2] == :invalid_type && msg[3][:value] == 'skip'

    p msg
    false
  end

  paths = Dir['spec/fixtures/configs/**/*.yml'].sort
  paths = paths.reject { |path| skip.any? { |skip| path.include?(skip) } }
  paths = paths[0..10_000]

  configs = paths.map { |path| [path, File.read(path)] }

  subject { described_class.apply(parse(yaml), alert: true, fix: true) }

  configs.each do |path, config|
    describe path.sub('spec/fixtures/configs/', '') do
      let(:path) { path }
      yaml config
      it { should_not have_msg(method(:filter)) }
    end
  end
end

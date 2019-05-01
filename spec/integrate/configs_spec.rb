require 'yaml'

def symbolize(obj)
  Travis::Yml::Helper::Obj.symbolize(obj)
end

# accept:
#
#   # should `skip` be a generic feature? (grondo:flux-core)
#   [:error, :"matrix.include.deploy", :invalid_type, {:expected=>:map, :actual=>:str, :value=>"skip"}]
#
#   # somehow relax env vars so that doesn't raise an error, but maybe just a warning?
#   [:error, :env, :invalid_type, {:expected=>:map, :actual=>:seq, :value=>["USER_LANGUAGE=en USER_REGION=US'"]}]
#

describe Travis::Yml, configs: true do
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
    stage: %i(
      after_error
    ),
    event: [
      :on_start,         # on notifications other than webhooks
      :on_cancel,        # on notifications other than webhooks
      :on_pull_requests, # on notifications other than slack
      :on_change,
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

  DEPRECATIONS = %i(
    cache_enable_all
    deprecated_value
    deprecated_sonarcloud_branches
    deprecated_sonarcloud_github_token
  )

  YAML_REFERENCE_TARGETS = %i(
    .apt_sources
    .check_moban
    .disable_global
    .mixins
    .org.ruby-lang.ci.matrix-definitions
    .deploy_job_template
    DEPLOY_TO_GITHUB
    GH_TOKEN
    INSTALL_AWS
    INSTALL_GECKODRIVER
    INSTALL_NODE_VIA_NVM
    addons_shortcuts
    aliases
    apt_targets
    aws_deploy_pants_pex
    aws_get_pants_pex
    default_test_config
    base_build_wheels
    base_deploy
    base_deploy_stable_muliplatform_pex
    base_deploy_unstable_multiplatform_pex
    base_jvm_tests
    base_linux_build_engine
    base_linux_build_wheels
    base_linux_config
    base_linux_test_config
    base_osx_10_12_sanity_check
    base_osx_10_13_sanity_check
    base_osx_build_engine
    base_osx_build_wheels
    base_osx_config
    base_osx_sanity_check
    base_osx_test_config
    base_rust_lints
    base_rust_tests
    cargo_audit
    cmake_install
    cmake_script
    common_sources
    conan-linux
    conan-osx
    defaults
    defaults_go
    defaults_js
    docker_cmake_install
    docker_cmake_script
    docker_make_script
    docker_template
    doctr
    e2e_tests
    eccube_setup
    flake8-steps
    install_linux
    install_mongo
    node_js_defaults
    docker_defaults
    include_base
    install_osx
    integration_script
    java_11
    java_8
    karma_runner
    linux
    linux-ppc64le
    linux32_install
    linux64_install
    linux_apt_template
    linux_rust_clippy
    linux_rust_tests
    linux_template
    linux_with_fuse
    linux-gcc-7
    linux-gcc-8
    linux_clang
    linux_gcc
    mpi_linux_clang
    mpi_linux_gcc
    osx_clang
    mac_before_install
    macos_template
    make_install
    make_script
    max_amd64_conf
    max_amd64_deps
    max_x86_conf
    max_x86_deps
    min_amd64_conf
    min_amd64_deps
    native_engine_cache_config
    node-preset
    node_js-steps
    osx
    osx_rust_tests
    package_api_setup
    packagecloud_deb_template
    packagecloud_rpm_template
    pants_run_cache_config
    pkg_deps_prereqs_distro
    pkg_deps_devtools
    pkg_deps_doctools
    pkg_deps_prereqs
    pkg_deps_prereqs_distro
    pkg_deps_prereqs_source
    pkg_deps_zproject
    pkg_src_zeromq_ubuntu12
    pkg_src_zeromq_ubuntu14
    pkg_src_zeromq_ubuntu16
    py27_deploy_stable_multiplatform_pex
    py27_deploy_unstable_multiplatform_pex
    py27_jvm_tests
    py27_lint
    py27_linux_build_engine
    py27_linux_build_wheels_ucs2
    py27_linux_build_wheels_ucs4
    py27_linux_config
    py27_linux_test_config
    py27_osx_10_12_sanity_check
    py27_osx_10_13_sanity_check
    py27_osx_build_engine
    py27_osx_build_wheels_ucs2
    py27_osx_build_wheels_ucs4
    py27_osx_config
    py27_osx_platform_tests
    py27_osx_test_config
    py36_deploy_stable_multiplatform_pex
    py36_deploy_unstable_multiplatform_pex
    py36_jvm_tests
    py36_lint
    py36_linux_build_engine
    py36_linux_build_wheels
    py36_linux_config
    py36_linux_test_config
    py36_osx_10_12_sanity_check
    py36_osx_10_13_sanity_check
    py36_osx_build_engine
    py36_osx_build_wheels
    py36_osx_config
    py36_osx_platform_tests
    py36_osx_test_config
    py37_jvm_tests
    py37_lint
    py37_linux_build_engine
    py37_linux_config
    py37_linux_test_config
    py37_osx_10_12_sanity_check
    py37_osx_10_13_sanity_check
    py37_osx_build_engine
    py37_osx_config
    py37_osx_platform_tests
    py37_osx_test_config
    run_tests_under_pantsd
    scala_version_211
    scala_version_212
    scala_version_213
    scoot_integration_tests
    script-anchors
    stage_generic_linux
    stage_generic_linuxg
    stage_linux_36
    stage_linux_36g
    stage_linux_37
    stage_linux_37_omp
    stage_linux_37_ompg
    stage_linux_37_openblas
    stage_linux_37_openblasg
    stage_linux_37g
    stage_osx
    stage_osxg
    templates
    testSmokeCy
    testPostDeploy
    travis_docker_image
    unit_script
    windows_template
    x-ccache-setup-steps
    x-linux-27-shard
    x-linux-37-shard
    x-linux-pypy-shard
    x-linux-shard
    x-osx-27-shard
    x-osx-37-shard
    x-osx-shard
    x-osx-ssl
    x-py27
    x-py37
    x-pyenv-shard
    x-pypy
    x_base_steps
  )

  YAML_CUSTOM_CONFIG = %i(
    coverage
    dd
    travisBuddy
    SECRET_KEY_BASE=593146e0067b8b14fcdcd5ebfc0b4b0e987a889f
  )

  UNKNOWN_KEYS = {
    addons: %i(
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
    'addons.apt': %i(
      cache
      chrome
      config
      coverity_scan
      packages-without-jansson
      ssh_known_hosts
    ),
    'addons.artifacts': %i(
      acl
      provider
    ),
    # is conditions on coverity_scan actually unknown?
    'addons.coverity_scan': %i(
      condition
    ),
    'addons.coverity_scan.project': %i(
      branch_pattern
      build_command
    ),
    'addons.sonarcloud': %i(
      script
    ),
    branches: %i(
      branches
      global
      submodules
    ),
    cache: %i(
      before_cache
      branches
      cache
      files
      gradle
      install
      override
      python
    ),
    deploy: %i(
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
      if
      local_dir
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
    'deploy.on': %i(
      distributions
      java
      master
      onBranch
      prerelease
      skip_cleanup
    ),
    env: %i(
      allow_failures
      fast_finish
      os
      secure
    ),
    git: %i(
      clone
      go_import_path
    ),
    # is sudo on matrix actually unknown?
    matrix: %i(
      before_install
      global
      sudo
    ),
    'matrix.allow_failures': %i(
      canfail
    ),
    # should filter_secrets be valid?
    'matrix.include': %i(
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
    'matrix.include.addons': %i(
      cache
      sources
      sonarqube
    ),
    'matrix.include.addons.apt': %i(
      config
      sources
    ),
    'matrix.include.cache': %i(
      override
    ),
    # it's kinda fun that travis-ci/dpl has invalid keys on the rubygems
    # provider (script and if)
    'matrix.include.deploy': %i(
      app
      repo
      github_commit
      if
      overwrite
      script
    ),
    # TODO master should probably be allowed here, shouldn't it?
    'matrix.include.deploy.on': %i(
      on
      script
      master
    ),
    # notifications.if would make a ton of sense, actually
    notifications: %i(
      branches
      channels
      if
      recipients
      skip_join
      template
      urls
      use_notice
    ),
    'notifications.email': %i(
      slack
    ),
    'notifications.hipchat': %i(
      secure
    ),
    'notifications.irc': %i(
      branches
      only
      on_error
    ),
    'notifications.slack': %i(
      email
      format
      on
      secure
      slack
    ),
    'notifications.webhooks': %i(
      slack
    ),
    # is name actually unknown on root? or does it propagate to the jobs?
    root: %i(
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
      test
      versions
      webhooks
      wttd-notifications
      yarn
    ),
    stages: %i(
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
    language
    matrix.fast_finish
    matrix.allow_failures.rvm
    matrix.include.addons.apt.update
    matrix.include.addons.homebrew.update
    matrix.include.deploy.script
    matrix.include.compiler
    matrix.include.go
    matrix.include.jdk
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
      matrix
    ),
    # on scripts this is often caused by YAML parsing a quoted string with a colon into a map
    map: %i(
      arch
      after_failure
      deploy.api_key
      deploy.env
      deploy.on.branch
      matrix.include.cache.directories
      matrix.include.script
      matrix.include.after_script
      after_success
    ),
  }

  INVALID_CONDITIONS = [
    '(branch = dev) AND (type IS cron)' # invalid condition (should be type = cron)
  ]

  UNKNOWN_VARS = %w(
    repository_name,
  )

  ENUMS = %i(
    notifications.hipchat.format
  )

  # how much of this is true?
  UNSUPPORTED = {
    android: %w(
      cpp
    ),
    bundler_args: %w(
      java
      node_js
      python
    ),
    compiler: %w(
      java
      erlang
      generic
      nix
      node_js
      objective-c
      php
      python
      r
      ruby
      shell
    ),
    d: %w(
      generic
      shell
    ),
    dist: %w(
      osx
    ),
    go: %w(
      python
    ),
    jdk: %w(
      c
      cpp
      go
      node_js
      objective-c
      php
      python
      osx
    ),
    node_js: %w(
      android
      cpp
      clojure
      csharp
      generic
      go
      java
      groovy
      ruby
      rust
      objective-c
      php
      python
      scala
      shell
    ),
    pandoc_version: %w(
      php
    ),
    perl: %w(
      node_js
    ),
    python: %w(
      android
      c
      cpp
      csharp
      erlang
      generic
      go
      java
      node_js
      php
      ruby
      scala
      shell
    ),
    rvm: %w(
      cpp
      erlang
      go
      java
      node_js
      python
    ),
    scala: %w(
      java
    ),
    smalltalk: %w(
      bash
      shell
    ),
    osx_image: %w(
      linux
    ),
    osx: %w(
      perl
      scala
    ),
    solution: %w(
      node_js
    ),
    virtualenv: %(
      cpp
      node_js
    ),
    warnings_are_errors: %w(
      python
    ),
    windows: %w(
      sh
      php
    ),
  }

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
    msg[2] == :deprecated && DEPRECATIONS.include?(msg[3][:deprecation])
  end

  # unknown key for YAML references/aliases, would be nice if we could know Psych has resolved a node from this key
  def yaml_reference_target?(msg)
    msg[2] == :unknown_key && YAML_REFERENCE_TARGETS.include?(msg[3][:key]) && %i(root matrix).include?(msg[1])
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
  vars

  def invalid_env_var?(msg)
    return false unless msg[2] == :invalid_env_var
    INVALID_ENV_VARS.include?(msg[3][:var]) || msg[3][:var].include?('CONDA_ENVIRONMENT')
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
    # return false unless msg[2] == :unsupported
    # return true if UNSUPPORTED[msg[3][:key]]&.include?(msg[3][:on_value])
    # msg[3][:value].is_a?(String) && UNSUPPORTED[msg[3][:value].to_sym]&.include?(msg[3][:on_value])
  end

  def unknown_value(msg, &block)
    return false unless  msg[2] == :unknown_value
    return false unless ENUMS.include?(msg[1])
    block ? block.call(msg[3][:value]) : true
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

    return true if typo?(msg)
    return true if potential_alias?(msg)
    return true if deprecated?(msg)

    return true if dist_group_expansion?(msg)  # the feature flag allowing this is off on both org and com
    return true if unsupported_dist?(msg)

    return true if unknown_value(msg) { |value| value.include?('%{repository}') } # template string on hipchat.format

    return true if yaml_reference_target?(msg) # people using unknown keys for storing yaml references
    return true if yaml_custom_config?(msg)    # people using .travis.yml as a config store that they parse at build time
    return true if questionable_env?(msg)      # should investigate these again

    return true if unknown_key?(msg)           # actually misplaced keys
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
    # fix this
    return true if msg == [:warn, :cache, :deprecated, deprecation: :cache_enable_all, value: false]

    p msg
    false
  end

  paths = Dir['spec/fixtures/configs/**/*.yml'].sort
  paths = paths.reject { |path| skip.any? { |skip| path.include?(skip) } }
  paths = paths[0..10_000]

  configs = paths.map { |path| [path, File.read(path)] }

  subject { described_class.apply(parse(yaml)) }

  configs.each do |path, config|
    describe path.sub('spec/fixtures/configs/', '') do
      yaml config
      it { should_not have_msg(method(:filter)) }
    end
  end
end

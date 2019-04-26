require 'yaml'

def symbolize(obj)
  Travis::Yml::Helper::Obj.symbolize(obj)
end

# accept:
#
#   # probably to be accepted
#   [:error, :"matrix.include.addons.coverity_scan.notification_email", :invalid_type, {:expected=>:str, :actual=>:secure, :value
#
#   # hmmm?
#   [:warn, :"addons.artifacts", :find_key, {:original=>:access_key_id, :key=>:access_key}
#
#   # results in invalid_type on deploy.on.branch
#   deploy:
#     provider: pypi
#     on:
#       distributions: sdist bdist_wheel
#
#    # not sure ...
#    env:
#      -
#      - FOO=foo
#
#   # results in invalid_seq value: nil on notifications.emails.recipients
#   notifications:
#   email:
#     recipients:
#       - tomaug@ceh.ac.uk
#
#   # shouldn't this be prefixed?
#   notifications:
#     slack:
#       - secure: str
#
#   # clean_value should check how many chars it removes, or something:
#   [:warn, :language, :clean_value, {:original=>"python - \"3.6\"", :value=>"python"}]
#   [:warn, :language, :clean_value, {:original=>"java scala node_js", :value=>"java"}]
#
#   # do we not check the language before we check support?
#   [:warn, :"matrix.include.compiler", :unsupported, {:on_key=>:language, :on_value=>"node_js - \"9\"", :key=>:compiler, :value=>["

#   # does this work in production? (elmsln:elmsln)
#   matrix:
#     env:
#       global:
#         - ES_VER=1.0.1
#
#   # does this work in production? (fossasia:susi_server)
#   matrix:
#     include:
#       env:
#         global:
#           - GH_REF: github.com/fossasia/susi_server.git
#           - secure: WAjBBsbaxnj+6N9wu3v20AVcikJB4Q9U4CuqR1Ws8jPlRl5e8LxMzwQreFokEk22ymIuOpMMChTqdZTMtEQI24xPaDIpGd9byo5XYjX8Ln1LD0ndXboRdf0WNG88rtrQmaTvGKG6ahEzAFlmgwJ62ahA+DxuTDLKypWNNymqk49mmbV2g2c2Leh9fJYIDEGg3elZrKJnsretTo/PMC9SJP32W+3xonUh43FxinGJU+UEXXF9VtoMhfxCxl2zC4w2pXvrJpHhtw2tB42P2fHRH/MYOwM7okstgyBdIfWLMjWPSrpMosTQx3LrtX35tVNEqGmqPlYDXKFzeX0vawUtc08hQgIz2eWrc4YJ8YoAxuUCMW2OodEoLEuOizP59eAAJ3jmPlH1kY50T0JOxS47AxSLYT9QQWNKbGEX0EPfKSqNTTmUZb/RaXR3iYNJKZLS+9rZ91Ck3rmuMqxdJOsrZ6zWpxX6spNOqjtLrQvQaHcpK9JDFBE7oTf5fR2r+b4yY7K2cYCLDhUJfGC64qfVutwFQYhQx+QEEODiiR3ubSXrvH9IzAmlWrq8sUJB7qCOpyIb3AraH72BhGL1XgQIEodx7wkX4ZWTCu1q6GoY6MUbu270dPHTRcoesTh2LFCriqAKzKXia2EQiYZXFi18Vo2YQ/Km2FAWhdJZrhgVl9M=
#           - PATH=$PATH:${HOME}/google-cloud-sdk/bin
#           - CLOUDSDK_CORE_DISABLE_PROMPTS=1
#
#   # holy shit, geoblacklight:geoblacklight is using this, and it might actually work
#   global_env:
#     - FOO=str
#
#   # should `skip` be a generic feature? (grondo:flux-core)
#   [:error, :"matrix.include.deploy", :invalid_type, {:expected=>:map, :actual=>:str, :value=>"skip"}]
#
#   # these don't look great:
#   [:warn, :root, :find_key, {:original=>:mac_before_install, :key=>:before_install}]
#   [:warn, :root, :find_key, {:original=>:make_install, :key=>:after_install}]
#
#   # wat, his is a valid condition, isn't it?
#   [:error, :"matrix.include.if", :invalid_condition, {:condition=>"(branch = dev) AND (type IS cron)"}]
#
#   # somehow relax env vars so that doesn't raise an error, but maybe just a warning?
#   [:error, :env, :invalid_type, {:expected=>:map, :actual=>:seq, :value=>["USER_LANGUAGE=en USER_REGION=US'"]}]
#
#   # can we communicate that sonarqube is gone?
#
#   # if a deploy provider has been detected by :provider, can this be included to all message?
#
#   # should this be a stop word?
#   [:warn, :root, :find_key, {:original=>:osx, :key=>:os}]
#
#   # bring back repair_value?
#   [:error, :"matrix.include.after_script", :invalid_type, {:expected=>:str, :actual=>:map, :value=>{:"echo \"========== Server log"=>"============\""}}]


describe Travis::Yml, configs: true do
  skip = [
    'andela:ah-frontend-thor',                 # addons: codeclimate (not sure if this should pass)
    'ApollosProject:apollos-prototype',        # bogus deploy.master: true (not sure if this should pass)
    'apache:incubator-openwhisk-cli',          # deploy.on.tags: $TAG (not sure if this should pass, docs are a little weird there)
    'apache:incubator-openwhisk-wskdeploy',    # deploy.on.tags: $TAG (not sure if this should pass, docs are a little weird there)

    # bug in Psych?
    'artisan-roaster-scope:artisan',           # yaml turning a string containing a colon into a map even though quoted: export UPLOADTOOL_BODY="WARNING: pre-release builds may not work. Use at your own risk."

    # accept
    'active-citizen',
    '42ity:fty-rest', # all sorts of msgs
  ]

  def filter(msg)
    return true if msg[0] == :info
    # return true if msg[2] == :empty

    # unknown languages
    return true if msg[1] == :language && msg[3][:value] == 'common-lisp'
    return true if msg[1] == :language && msg[3][:value] == 'emacs-lisp'
    return true if msg[1] == :language && msg[3][:value] == 'general'
    return true if msg[1] == :language && msg[3][:value] == 'js' # restore the alias
    return true if msg[1] == :language && msg[3][:value] == 'kotlin'
    return true if msg[1] == :language && msg[3][:value] == 'none'
    return true if msg[1] == :language && msg[3][:value] == 'sage'
    return true if msg[1] == :language && msg[3][:value] == 'sh' # restore the alias

    # unknown os
    return true if msg[1] == :'matrix.include.os' && msg[3][:value] == 'linux-ppc64le'

    # unknown dist
    return true if msg[1] == :dist && msg[3][:value] == 'bionic'
    return true if msg[1] == :dist && msg[3][:value] == 'current'

    # unknown services
    return true if msg[2] == :unknown_value && msg[3][:value] == 'haveged'
    return true if msg[2] == :unknown_value && msg[3][:value] == 'ignore'
    return true if msg[2] == :unknown_value && msg[3][:value] == 'mariadb'
    return true if msg[2] == :unknown_value && msg[3][:value] == 'pgsql'
    return true if msg[2] == :unknown_value && msg[3][:value] == 'zookeeper'

    # dist/group expansion (the feature flag allowing this is off on both org and com)
    return true if msg[2] == :invalid_seq && msg[1] == :dist

    # fix this
    return true if msg == [:warn, :cache, :deprecated, deprecation: :cache_enable_all, value: false]

    # rename to :unexpected_seq and move to :info
    return true if msg[2] == :invalid_seq && msg[1] == :language
    return true if msg[2] == :invalid_seq && msg[1] == :addons && msg[3][:value].keys.include?(:chrome)
    return true if msg[2] == :invalid_seq && msg[1] == :'deploy.script'
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.include.deploy.script'
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.include.os'

    # bogus invalid_seq on notifications.email.recipients
    return true if msg[2] == :invalid_seq && msg[1] == :'notifications.email.recipients'

    # invalid_seq due to bogus YAML references
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.include.addons.apt.packages'
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.exclude.addons.apt.packages'

    # misc invalid_seq
    return true if msg[2] == :invalid_seq && msg[1] == :'deploy.api_key'
    return true if msg[2] == :invalid_seq && msg[1] == :addons
    return true if msg[2] == :invalid_seq && msg[1] == :osx_image
    return true if msg[2] == :invalid_seq && msg[1] == :sudo
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.fast_finish' # [true]
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.include.addons.apt.update'
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.include.addons.homebrew.update'
    return true if msg[2] == :invalid_seq && msg[1] == :'addons.coverity_scan.build_command'
    return true if msg[2] == :invalid_seq && msg[1] == :'deploy.password'
    return true if msg[2] == :invalid_seq && msg[1] == :notifications && msg[3][:value] == { email: false }
    return true if msg[2] == :invalid_seq && msg[1] == :'notifications.flowdock.api_token'

    # unsupported dist
    return true if msg[2] == :unknown_value && msg[3][:value] == 'bionic'

    # typo
    return true if msg[2] == :find_value && msg[3][:original] == '-docker'
    return true if msg[2] == :find_value && msg[3][:original] == 'trust'
    return true if msg[2] == :find_value && msg[3][:original] == 'alwayss'
    return true if msg[2] == :clean_key  && msg[3][:original] == :_addons
    return true if msg[2] == :find_key   && msg[3][:original] == :deployg
    return true if msg[2] == :find_key   && msg[3][:original] == :pyton
    return true if msg[2] == :find_key   && msg[3][:original] == :state  # should have been stage
    return true if msg[2] == :find_key   && msg[3][:original] == :serivce
    return true if msg[2] == :find_key   && msg[3][:original] == :'keep-hisotry'
    return true if msg[2] == :find_key   && msg[3][:original] == :'commiter-from-gh'
    return true if msg[2] == :find_key   && msg[3][:original] == :langauge

    # just wrong
    return true if msg[2] == :find_key   && msg[3][:original] == :'before-caching'

    # alias
    return true if msg[2] == :find_value && msg[3][:original] == 'nodejs'
    return true if msg[2] == :find_value && msg[3][:original] == 'require'
    return true if msg[2] == :find_key   && msg[3][:original] == :notification
    return true if msg[2] == :find_key   && msg[3][:original] == :addon
    return true if msg[2] == :find_key   && msg[3][:original] == :service

    # deprecated alias key?
    return true if msg[2] == :unknown_key   && msg[3][:key] == :fail_fast
    return true if msg[2] == :unknown_key   && msg[3][:key] == :lang
    return true if msg[2] == :misplaced_key && msg[3][:key] == :username && msg[1] == :'matrix.include.deploy'
    return true if msg[2] == :find_key      && msg[3][:original] == :add_ons
    return true if msg[2] == :find_key      && msg[3][:original] == :allow_failure
    return true if msg[2] == :find_key      && msg[3][:original] == :scripts
    return true if msg[2] == :find_key      && msg[3][:original] == :caches

    # how much of this is true?
    return true if msg[2] == :unsupported && msg[3][:key] == :bundler_args && msg[3][:on_value] == 'java'
    return true if msg[2] == :unsupported && msg[3][:key] == :bundler_args && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'java'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'erlang'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'generic'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'php'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'python'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'r'
    return true if msg[2] == :unsupported && msg[3][:key] == :compiler     && msg[3][:on_value] == 'shell'
    return true if msg[2] == :unsupported && msg[3][:key] == :d            && msg[3][:on_value] == 'generic'
    return true if msg[2] == :unsupported && msg[3][:key] == :dist         && msg[3][:on_value] == 'osx'
    return true if msg[2] == :unsupported && msg[3][:key] == :jdk          && msg[3][:on_value] == 'c'
    return true if msg[2] == :unsupported && msg[3][:key] == :jdk          && msg[3][:on_value] == 'cpp'
    return true if msg[2] == :unsupported && msg[3][:key] == :jdk          && msg[3][:on_value] == 'go'
    return true if msg[2] == :unsupported && msg[3][:key] == :jdk          && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :jdk          && msg[3][:on_value] == 'python'
    return true if msg[2] == :unsupported && msg[3][:key] == :jdk          && msg[3][:on_value] == 'osx'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'android'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'cpp'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'clojure'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'csharp'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'generic'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'java'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'groovy'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'ruby'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'rust'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'objective-c'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'php'
    return true if msg[2] == :unsupported && msg[3][:key] == :node_js      && msg[3][:on_value] == 'python'
    return true if msg[2] == :unsupported && msg[3][:key] == :perl         && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'android'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'c'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'cpp'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'erlang'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'generic'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'go'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'ruby'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'scala'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'sh'
    return true if msg[2] == :unsupported && msg[3][:key] == :python       && msg[3][:on_value] == 'shell'
    return true if msg[2] == :unsupported && msg[3][:key] == :rvm          && msg[3][:on_value] == 'erlang'
    return true if msg[2] == :unsupported && msg[3][:key] == :rvm          && msg[3][:on_value] == 'java'
    return true if msg[2] == :unsupported && msg[3][:key] == :rvm          && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :rvm          && msg[3][:on_value] == 'python'
    return true if msg[2] == :unsupported && msg[3][:key] == :scala        && msg[3][:on_value] == 'java'
    return true if msg[2] == :unsupported && msg[3][:key] == :osx_image    && msg[3][:on_value] == 'linux'
    return true if msg[2] == :unsupported && msg[3][:key] == :smalltalk    && msg[3][:on_value] == 'bash'
    return true if msg[2] == :unsupported && msg[3][:key] == :solution     && msg[3][:on_value] == 'node_js'
    return true if msg[2] == :unsupported && msg[3][:key] == :warnings_are_errors && msg[3][:on_value] == 'python'
    return true if msg[2] == :unsupported && msg[3][:value] == 'osx'       && msg[3][:on_value] == 'scala'
    return true if msg[2] == :unsupported && msg[3][:value] == 'windows'   && msg[3][:on_value] == 'sh' # restore the alias

    # after_error stage
    return true if msg[2] == :unknown_key && msg[3][:key] == :after_error

    # on_start, on_cancel on notifications other than webhooks
    return true if msg[2] == :misplaced_key && msg[3][:key] == :on_start
    return true if msg[2] == :misplaced_key && msg[3][:key] == :on_cancel

    # on_pull_requests on notifications other than slack
    return true if msg[2] == :misplaced_key && msg[3][:key] == :on_pull_requests

    # on_change on notifications.email
    return true if msg[2] == :unknown_key && msg[3][:key] == :on_change

    # deprecations
    return true if msg[2] == :deprecated && msg[3][:deprecation] == :cache_enable_all
    return true if msg[2] == :deprecated && msg[3][:deprecation] == :deprecated_sonarcloud_branches
    return true if msg[2] == :deprecated && msg[3][:deprecation] == :deprecated_sonarcloud_github_token

    # unknown key for YAML references/aliases, would be nice if we could know
    # Psych has resolved a node from this key
    return true if msg[2] == :unknown_key && msg[1] == :matrix && msg[3][:key] == :templates
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'.apt_sources'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'.check_moban'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'.disable_global'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'conan-linux'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'conan-osx'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'flake8-steps'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'linux-ppc64le'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :'node-preset'
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :aliases
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :apt_targets
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :common_sources
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :defaults
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :defaults_go
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :defaults_js
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :doctr
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :docker_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :linux_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :linux_apt_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :macos_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :packagecloud_deb_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :packagecloud_rpm_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :windows_template
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :install_linux
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :install_osx
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :linux32_install
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :linux64_install
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :docker_cmake_install
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :docker_cmake_script
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :docker_make_script
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :cmake_install
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :cmake_script
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :make_script
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :scala_version_211
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :scala_version_212
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :scala_version_213
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :java_8
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :java_11

    # unkown keys that look like the user might parse .travis.yml during the build
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :coverage    # CompassionCH:compassion-modules
    return true if msg[2] == :unknown_key && msg[1] == :root   && msg[3][:key] == :travisBuddy # HoeenCoder::Wavelength

    # unknown and misplaced keys
    return true if msg[2] == :misplaced_key && msg[3][:key] == :branches        && msg[1] == :addons
    return true if msg[2] == :misplaced_key && msg[3][:key] == :sources         && msg[1] == :addons
    return true if msg[2] == :misplaced_key && msg[3][:key] == :packages        && msg[1] == :addons
    return true if msg[2] == :unknown_key   && msg[3][:key] == :sonarqube       && msg[1] == :addons
    return true if msg[2] == :unknown_key   && msg[3][:key] == :ulimit          && msg[1] == :addons
    return true if msg[2] == :misplaced_key && msg[3][:key] == :provider        && msg[1] == :'addons.artifacts'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :acl             && msg[1] == :'addons.artifacts'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :condition       && msg[1] == :'addons.coverity_scan'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :cache           && msg[1] == :'addons.apt'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :config          && msg[1] == :'addons.apt'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :ssh_known_hosts && msg[1] == :'addons.apt'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :branches        && msg[1] == :branches
    return true if msg[2] == :misplaced_key && msg[3][:key] == :submodules      && msg[1] == :branches
    return true if msg[2] == :misplaced_key && msg[3][:key] == :before_cache    && msg[1] == :cache
    return true if msg[2] == :unknown_key   && msg[3][:key] == :override        && msg[1] == :cache
    return true if msg[2] == :misplaced_key && msg[3][:key] == :os              && msg[1] == :env
    return true if msg[2] == :misplaced_key && msg[3][:key] == :fast_finish     && msg[1] == :env
    return true if msg[2] == :misplaced_key && msg[3][:key] == :go_import_path  && msg[1] == :git
    return true if msg[2] == :misplaced_key && msg[3][:key] == :global          && msg[1] == :matrix
    return true if msg[2] == :misplaced_key && msg[3][:key] == :sudo            && msg[1] == :matrix
    return true if msg[2] == :misplaced_key && msg[3][:key] == :apt             && msg[1] == :'matrix.include'
    return true if msg[2] == :unknown_key   && msg[3][:key] == :distribution    && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :fast_finish     && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :file            && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :on              && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :provider        && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :skip_cleanup    && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :version         && msg[1] == :'matrix.include'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :cache           && msg[1] == :'matrix.include.addons'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :sources         && msg[1] == :'matrix.include.addons'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :config          && msg[1] == :'matrix.include.addons.apt'
    return true if msg[2] == :unknown_key   && msg[3][:key] == :override        && msg[1] == :'matrix.include.cache'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :apt             && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :allow_failures  && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :code_climate    && msg[1] == :root
    return true if msg[2] == :unknown_key   && msg[3][:key] == :deploy_docs     && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :directories     && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :email           && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :global          && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :global_env      && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :include         && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :licenses        && msg[1] == :root
    return true if msg[2] == :unknown_key   && msg[3][:key] == :linux           && msg[1] == :root
    return true if msg[2] == :unknown_key   && msg[3][:key] == :mysql           && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :only            && msg[1] == :root
    return true if msg[2] == :unknown_key   && msg[3][:key] == :sbt             && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :secure          && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :sources         && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :tags            && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :test            && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :webhooks        && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :on_failure      && msg[1] == :root
    return true if msg[2] == :misplaced_key && msg[3][:key] == :branches        && msg[1] == :stages

    # misplaced stage on root
    return true if msg[2] == :find_key && msg[3][:original] == :stage && msg[1] == :root

    # misplaced notifications on matrix.include
    return true if msg[2] == :misplaced_key && msg[3][:key] == :notifications && msg[1] == :'matrix.include'

    # misplaced keys on notifications
    return true if msg[2] == :misplaced_key && msg[3][:key] == :recipients    && msg[1] == :notifications
    return true if msg[2] == :misplaced_key && msg[3][:key] == :skip_join     && msg[1] == :notifications
    return true if msg[2] == :misplaced_key && msg[3][:key] == :urls          && msg[1] == :notifications
    return true if msg[2] == :misplaced_key && msg[3][:key] == :slack         && msg[1] == :'notifications.email'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :secure        && msg[1] == :'notifications.hipchat'

    # unknown keys on deploy and deploy.on
    return true if msg[2] == :misplaced_key && msg[3][:key] == :all_branches  && msg[1] == :deploy
    return true if msg[2] == :misplaced_key && msg[3][:key] == :script        && msg[1] == :deploy # script on npm
    return true if msg[2] == :unknown_key   && msg[3][:key] == :access        && msg[1] == :deploy # S3 acl?
    return true if msg[2] == :misplaced_key && msg[3][:key] == :before_deploy && msg[1] == :deploy
    return true if msg[2] == :misplaced_key && msg[3][:key] == :after_deploy  && msg[1] == :deploy
    return true if msg[2] == :misplaced_key && msg[3][:key] == :condition     && msg[1] == :deploy
    return true if msg[2] == :unknown_key   && msg[3][:key] == :node          && msg[1] == :deploy
    return true if msg[2] == :misplaced_key && msg[3][:key] == :verbose       && msg[1] == :deploy # verbose on github pages
    return true if msg[2] == :misplaced_key && msg[3][:key] == :repo          && msg[1] == :deploy
    return true if msg[2] == :misplaced_key && msg[3][:key] == :distributions && msg[1] == :'deploy.on'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :repo          && msg[1] == :'matrix.include.deploy'

    # recognized as broken by the user (cfengine:core)
    return true if msg[2] == :invalid_type && msg[3][:actual] == :str && msg[1] == :'deploy.prerelease'

    # invalid_type
    return true if msg[2] == :invalid_type && msg[3][:actual] == :str  && msg[1] == :'deploy'
    return true if msg[2] == :invalid_type && msg[3][:actual] == :str  && msg[1] == :'env' && msg[3][:value].include?('global -')
    return true if msg[2] == :invalid_type && msg[3][:actual] == :bool && msg[1] == :'matrix.include.addons'
    return true if msg[2] == :invalid_type && msg[3][:actual] == :bool && msg[1] == :'matrix.include.deploy'
    return true if msg[2] == :invalid_type && msg[3][:actual] == :map  && msg[1] == :'matrix.include.env' && msg[3][:value].key?(:matrix)
    return true if msg[2] == :invalid_type && msg[3][:actual] == :map  && msg[1] == :'matrix.include.env' && msg[3][:value].key?(:global)
    return true if msg[2] == :invalid_type && msg[3][:actual] == :bool && msg[1] == :'matrix.allow_failures.addons'
    return true if msg[2] == :invalid_type && msg[3][:actual] == :bool && msg[1] == :'matrix.allow_failures.deploy'

    # unkown value
    return true if msg[2] == :unknown_value && msg[1] == :'notifications.hipchat.format' && msg[3][:value].include?('%{repository}')

    # deploy github release oktokit keys
    # https://github.com/octokit/octokit.rb/blob/master/lib/octokit/client/releases.rb
    return true if msg[1] == :deploy && msg[2] == :misplaced_key && msg[3][:key] == :api_key
    return true if msg[1] == :deploy && msg[2] == :unknown_key   && msg[3][:key] == :body
    return true if msg[1] == :deploy && msg[2] == :misplaced_key && msg[3][:key] == :name
    return true if msg[1] == :deploy && msg[2] == :unknown_key   && msg[3][:key] == :tag_name
    return true if msg[1] == :deploy && msg[2] == :unknown_key   && msg[3][:key] == :target_commitish
    return true if msg[1] == :deploy && msg[2] == :unknown_key   && msg[3][:key] == :options
    return true if msg[1] == :deploy && msg[2] == :unknown_key   && msg[3][:key] == :'preserve-history'
    return true if msg[1] == :'matrix.include.deploy' && msg[2] == :unknown_key   && msg[3][:key] == :body
    return true if msg[1] == :'matrix.include.deploy' && msg[2] == :misplaced_key && msg[3][:key] == :name

    # accept
    #
    # 3343/edge
    return true if msg[2] == :invalid_type && msg[1] == :'matrix.include.addons.coverity_scan.notification_email'
    # akumuli:Akumuli
    return true if msg[2] == :find_key && msg[3][:original] == :access_key_id
    # Carrene:restfulpy, ClimateImpactLab:impactlab-tools
    # return true if msg[2] == :invalid_type && msg[3][:actual] == :map && msg[1] == :'deploy.on.branch'
    # curl:curl (omg)
    return true if msg[2] == :invalid_seq && msg[1] == :'matrix.include.addons.apt.sources.name'
    # not sure
    return true if msg[2] == :invalid_seq && msg[1] == :'env.matrix'
    return true if msg[2] == :invalid_seq && msg[1] == :'notifications.slack'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :slack && msg[1] == :'notifications.slack'
    return true if msg[2] == :misplaced_key && msg[3][:key] == :secure && msg[1] == :'notifications.slack'
    # elmsln:elmsln
    return true if msg[2] == :misplaced_key && msg[3][:key] == :env && msg[1] == :matrix
    # firefox-devtools:debugger
    return true if msg[2] == :clean_value && msg[3][:original] == 'python - "3.6"'
    # fluent:fluent-bit
    return true if msg[2] == :unsupported && msg[3][:on_value] == 'node_js - "9"'
    # geoblacklight:geoblacklight
    return true if msg[2] == :unknown_key  && msg[3][:key] == :global_env
    # grondo:flux-core
    return true if msg[2] == :invalid_type && msg[3][:value] == 'skip'
    # HaxeFoundation:hashlink
    return true if msg[2] == :find_key && msg[3][:original] == :mac_before_install
    return true if msg[2] == :find_key && msg[3][:original] == :make_install
    # hammer-io:tyr
    return true if msg[2] == :invalid_condition && msg[3][:condition] == '(branch = dev) AND (type IS cron)'
    # hashmapinc:Drillflow
    return true if msg[2] == :invalid_type && msg[1] == :env && msg[3][:actual] == :seq
    # higlasss:higlass
    return true if msg[2] == :misplaced_key && msg[1] == :deploy && msg[3][:key] == :file
    # hyperion-project:hyperion.ng
    return true if msg[2] == :find_key && msg[3][:original] == :osx
    return true if msg[2] == :invalid_type && msg[3][:value] == { os: 'osx' }
    # apache:griffin
    return true if msg[1] == :language && msg[3][:original] == 'java scala node_js'
    # Azure:azure-ssk-for-net
    return true if msg[2] == :invalid_type && msg[1] == :'matrix.include.after_script' && msg[3][:actual] == :map

    p msg
    false
  end

  paths = Dir['spec/fixtures/configs/**/*.yml'].sort
  paths = paths.reject { |path| skip.any? { |skip| path.include?(skip) } }
  paths = paths[0..3500]
  # paths = paths[3500..5000]

  configs = paths.map { |path| [path, File.read(path)] }

  subject { described_class.apply(parse(yaml)) }

  configs.each do |path, config|
    describe path.sub('spec/fixtures/configs/', '') do
      yaml config
      it { should_not have_msg(method(:filter)) }
    end
  end
end

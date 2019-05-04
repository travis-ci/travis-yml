describe Travis::Yml::Doc::Change::Key do
  let(:schema) { Travis::Yml.expand }
  let(:change) { described_class.new(schema, nil) }

  describe 'clean_key' do
    subject { change.clean_key(key) }

    describe 'given .foo (custom key)' do
      let(:key) { '.foo' }
      it { should eq '.foo' }
    end

    describe 'given _foo (custom key)' do
      let(:key) { '_foo' }
      it { should eq '_foo' }
    end

    describe 'given __foo' do
      let(:key) { '__foo' }
      it { should eq 'foo' }
    end

    describe 'given foo_' do
      let(:key) { 'foo_' }
      it { should eq 'foo' }
    end

    describe 'given foo__' do
      let(:key) { 'foo__' }
      it { should eq 'foo' }
    end

    describe 'given foo-bar' do
      let(:key) { 'foo-bar' }
      it { should eq 'foo_bar' }
    end

    describe 'given foo--bar' do
      let(:key) { 'foo-bar' }
      it { should eq 'foo_bar' }
    end

    describe 'given foo bar' do
      let(:key) { 'foo bar' }
      it { should eq 'foo_bar' }
    end

    describe 'given foo-*' do
      let(:key) { 'foo-*' }
      it { should eq 'foo' }
    end
  end

  describe 'match_key' do
    subject { change.match_key(key) }

    %w(
      TZ
      after_error
      binary_packages
      c
      cabal
      cards
      codecov
      dd
      e2e_tests
      java
      mac_before_install
      make_install
      on
      on_change
      phpunit
      slack
      stage_osx
      use_bioc
      vendor
      wget
      yarn
    ).map do |key|
      describe "does not correct the key #{key}" do
        let(:schema) { Travis::Yml.expand }
        let(:key) { key }
        it { should eq nil }
      end
    end

    %w(
      after_vendor
      gcc
      golang
      html
      jvm
      nvm
      prose
      sdk
      trusty
      vimscript
    ).map do |key|
      describe "does not corrects the key #{key} (stopword)" do
        let(:schema) { Travis::Yml.expand }
        let(:key) { key }
        it { should eq nil }
      end
    end

    pairs = [
      ['add_ons', 'addons'],
      ['addon', 'addons'],
      ['addonts', 'addons'],
      ['adfter_success', 'after_success'],
      ['afer_success', 'after_success'],
      ['affter_success', 'after_success'],
      ['after__success', 'after_success'],
      # ['after_deployment', 'after_deploy'],
      ['after_fail', 'after_failure'],
      ['after_faile', 'after_failure'],
      ['after_failiure', 'after_failure'],
      ['after_failures', 'after_failure'],
      ['after_sccess', 'after_success'],
      ['after_scipt', 'after_script'],
      ['after_scripts', 'after_script'],
      ['after_scuccess', 'after_success'],
      ['after_succcess', 'after_success'],
      ['after_succes', 'after_success'],
      ['after_sucess', 'after_success'],
      ['after_test', 'after_result'],
      ['afterscript', 'after_script'],
      ['aftersuccess', 'after_success'],
      ['anguage', 'language'],
      ['ascript', 'script'],
      ['aufter_success', 'after_success'],
      ['bafore_install', 'before_install'],
      ['bebefore_install', 'before_install'],
      ['bebore_script', 'before_script'],
      ['becore_script', 'before_script'],
      ['befor_install', 'before_install'],
      ['befor_script', 'before_script'],
      ['before.install', 'before_install'],
      ['beforeScript', 'before_script'],
      ['before__install', 'before_install'],
      # ['before_archive', 'before_cache'],
      ['before_delpoy', 'before_deploy'],
      # ['before_deployment', 'before_deploy'],
      ['before_insall', 'before_install'],
      ['before_instal', 'before_install'],
      ['before_instrall', 'before_install'],
      ['before_intall', 'before_install'],
      ['before_isntall', 'before_install'],
      ['before_scrip', 'before_script'],
      ['before_scripe', 'before_script'],
      ['before_scripting', 'before_script'],
      ['before_scripts', 'before_script'],
      ['before_scrpit', 'before_script'],
      ['before_scrpt', 'before_script'],
      ['before_srcipt', 'before_script'],
      ['before_sript', 'before_script'],
      ['beforescript', 'before_script'],
      ['begore_script', 'before_script'],
      ['braches', 'branches'],
      ['bracnhes', 'branches'],
      ['brances', 'branches'],
      ['branched', 'branches'],
      ['branchers', 'branches'],
      ['branchs', 'branches'],
      ['breanches', 'branches'],
      ['brefore_install', 'before_install'],
      ['brefore_script', 'before_script'],
      ['bunbler_args', 'bundler_args'],
      ['bundle_args', 'bundler_args'],
      ['cach', 'cache'],
      ['cached', 'cache'],
      ['caches', 'cache'],
      ['cahce', 'cache'],
      ['compieler', 'compiler'],
      ['compile', 'compiler'],
      ['compilers', 'compiler'],
      ['compilier', 'compiler'],
      ['complier', 'compiler'],
      ['cript', 'script'],
      ['ddons', 'addons'],
      ['defore_install', 'before_install'],
      ['defore_script', 'before_script'],
      ['deployd', 'deploy'],
      ['deployg', 'deploy'],
      ['deply', 'deploy'],
      ['emfile', 'gemfile'],
      ['ervices', 'services'],
      ['esudo', 'sudo'],
      ['evn', 'env'],
      ['for_install', 'before_install'],
      ['fsudo', 'sudo'],
      ['fter_script', 'after_script'],
      ['glanguage', 'language'],
      ['hlanguage', 'language'],
      ['iinstall', 'install'],
      ['ilanguage', 'language'],
      ['instal', 'install'],
      ['intall', 'install'],
      ['intsall', 'install'],
      ['jdks', 'jdk'],
      ['jkd', 'jdk'],
      ['laguage', 'language'],
      ['laguange', 'language'],
      ['lalanguage', 'language'],
      ['lanage', 'language'],
      ['lanaguage', 'language'],
      ['lanauage', 'language'],
      ['langage', 'language'],
      ['langague', 'language'],
      ['langauage', 'language'],
      ['langauge', 'language'],
      ['langiage', 'language'],
      # ['langlanguage', 'language'],
      ['languace', 'language'],
      ['languag', 'language'],
      ['languagee', 'language'],
      ['languages', 'language'],
      ['languague', 'language'],
      ['languaje', 'language'],
      ['languanage', 'language'],
      ['languange', 'language'],
      ['languare', 'language'],
      ['languate', 'language'],
      ['langue', 'language'],
      ['langueage', 'language'],
      ['langugae', 'language'],
      ['langugage', 'language'],
      ['languge', 'language'],
      ['langulage', 'language'],
      ['languqge', 'language'],
      ['langurage', 'language'],
      ['langyage', 'language'],
      ['lannguage', 'language'],
      ['lanuage', 'language'],
      ['lanugage', 'language'],
      ['laugnage', 'language'],
      ['lauguage', 'language'],
      ['laungage', 'language'],
      ['launguage', 'language'],
      ['lenguage', 'language'],
      ['llanguage', 'language'],
      ['lnguage', 'language'],
      ['lunguage', 'language'],
      ['matix', 'matrix'],
      ['matrie', 'matrix'],
      ['maxtrix', 'matrix'],
      ['nguage', 'language'],
      ['nitifications', 'notifications'],
      ['nnotifications', 'notifications'],
      ['nojifications', 'notifications'],
      ['notfications', 'notifications'],
      ['notications', 'notifications'],
      ['noticications', 'notifications'],
      ['notifacations', 'notifications'],
      ['notifcations', 'notifications'],
      ['notifiactions', 'notifications'],
      ['notificactions', 'notifications'],
      ['notificaion', 'notifications'],
      ['notificaions', 'notifications'],
      ['notificaitons', 'notifications'],
      ['notificarions', 'notifications'],
      ['notificastions', 'notifications'],
      ['notificatios', 'notifications'],
      ['notificatons', 'notifications'],
      ['notificiations', 'notifications'],
      ['notificications', 'notifications'],
      ['notifictations', 'notifications'],
      ['notifictions', 'notifications'],
      ['notififation', 'notifications'],
      ['notigications', 'notifications'],
      ['notofocations', 'notifications'],
      ['phpp', 'php'],
      ['phps', 'php'],
      ['ptyhon', 'python'],
      ['pyhton', 'python'],
      ['pytho', 'python'],
      ['pythonl', 'python'],
      ['pyton', 'python'],
      # ['qqsudo', 'sudo'],
      ['rlanguage', 'language'],
      ['rmv', 'rvm'],
      ['rvms', 'rvm'],
      ['safter_script', 'after_script'],
      ['sbundler_args', 'bundler_args'],
      ['sccript', 'script'],
      ['scipt', 'script'],
      ['scirpt', 'script'],
      ['scriipt', 'script'],
      ['scrip', 'script'],
      ['scripe', 'script'],
      ['scripte', 'script'],
      ['scripts', 'script'],
      ['scrit', 'script'],
      ['scrpit', 'script'],
      ['scrpt', 'script'],
      ['sctipt', 'script'],
      ['sctript', 'script'],
      ['slanguage', 'language'],
      ['socript', 'script'],
      ['sodo', 'sudo'],
      ['sodu', 'sudo'],
      ['soultion', 'solution'],
      ['srcipt', 'script'],
      ['sript', 'script'],
      ['ssudo', 'sudo'],
      ['sude', 'sudo'],
      ['sudeo', 'sudo'],
      ['sudio', 'sudo'],
      ['sudu', 'sudo'],
      ['sx_image', 'osx_image'],
      ['udo', 'sudo'],
      ['xccode_sdk', 'xcode_sdk'],
      ['xcdoe_scheme', 'xcode_scheme'],
      ['xcode_projec', 'xcode_project'],
      ['xcode_schema', 'xcode_scheme'],
      ['xcode_xcworkspace', 'xcode_workspace'],
      ['xode_project', 'xcode_project'],
      ['xode_scheme', 'xcode_scheme'],
    ]
    pairs.map do |key, other|
      describe "corrects they key #{key} to #{other}" do
        let(:schema) { Travis::Yml.expand }
        let(:key) { key }
        it { should eq other }
      end
    end

    pairs = [
      ['coversity_scan', 'coverity_scan'],
      ['posgresql', 'postgresql'],
      ['postgesql', 'postgresql'],
      ['postgreslq', 'postgresql'],
      ['postgresq', 'postgresql'],
      ['postgressql', 'postgresql'],
    ]
    pairs.each do |(key, other)|
      describe "corrects they key #{key} to #{other}" do
        let(:schema) { Travis::Yml.expand.map['addons'] }
        let(:key) { key }
        it { should eq other }
      end
    end

    pairs = [
      ['direcetories', 'directories'],
      ['directiories', 'directories'],
      ['directores', 'directories'],
      ['directoriei', 'directories'],
      ['diretories', 'directories'],
      ['pacakges', 'packages'],
    ]
    pairs.each do |(key, other)|
      describe "corrects they key #{key} to #{other}" do
        let(:schema) { Travis::Yml.expand.map['cache'][0] }
        let(:key) { key }
        it { should eq other }
      end
    end

    pairs = [
      ['fash_finish', 'fast_finish'],
      ['fast_finis', 'fast_finish'],
      ['fast_finishe', 'fast_finish'],
      ['fast_finished', 'fast_finish'],
      ['alllow_failure', 'allow_failures'],
      ['allo_failures', 'allow_failures'],
      ['allow_failtures', 'allow_failures'],
      ['allow_failues', 'allow_failures'],
      ['allow_faliures', 'allow_failures'],
      ['allow_falures', 'allow_failures'],
      ['allow_features', 'allow_failures'],
      # ['allowable_failures', 'allowed_failures'], # :thinking_face:
      ['allows_failures', 'allow_failures'],
    ]
    pairs.each do |(key, other)|
      describe "corrects they key #{key} to #{other}" do
        let(:schema) { Travis::Yml.expand.map['matrix'][0] }
        let(:key) { key }
        it { should eq other }
      end
    end

    pairs = [
      ['emai', 'email'],
      ['cn_failure', 'on_failure'],
      ['o_failure', 'on_failure'],
      ['on_cussess', 'on_success'],
      ['on_failed', 'on_failure'],
      ['on_failiure', 'on_failure'],
      ['on_faillure', 'on_failure'],
      ['on_failture', 'on_failure'],
      ['on_failue', 'on_failure'],
      ['on_failuer', 'on_failure'],
      ['on_faiulre', 'on_failure'],
      ['on_faliure', 'on_failure'],
      ['on_faulure', 'on_failure'],
      ['on_succes', 'on_success'],
      ['on_successs', 'on_success'],
      ['on_sucess', 'on_success'],
      ['on_sucsess', 'on_success'],
      ['onfailure', 'on_failure'],
      ['onsuccess', 'on_success'],
    ]
    pairs.each do |(key, other)|
      describe "corrects they key #{key} to #{other}" do
        let(:schema) { Travis::Yml.expand.map['notifications'][0] }
        let(:key) { key }
        it { should eq other }
      end
    end

    pairs = [
      ['receipients', 'recipients'],
      ['recepients', 'recipients'],
      ['recipents', 'recipients'],
      ['recipient', 'recipients'],
    ]
    pairs.each do |(key, other)|
      describe "corrects they key #{key} to #{other}" do
        let(:schema) { Travis::Yml.expand.map['notifications'][0]['email'][0] }
        let(:key) { key }
        it { should eq other }
      end
    end
  end
end

describe Travis::Yaml::Spec::Def::Root do
  let(:spec) { described_class.new.spec }
  let(:map)  { spec[:map] }

  let(:expand) do
    %i(
      os env jdk compiler crystal dotnet mono solution d dart elixir
      otp_release go ghc haxe hxml julia node_js xcode_sdk xcode_scheme podfile
      perl perl6 php python r ruby gemfile rust scala smalltalk
    )
  end

  let(:keys) do
    %i(
      language os dist group sudo osx_image addons branches cache deploy git
      matrix notifications services source_key env before_install install
      before_script script after_script after_result after_success
      after_failure before_deploy after_deploy before_cache jdk android
      compiler lein crystal dotnet mono solution d dart with_content_shell
      elixir otp_release go gobuild_args go_import_path ghc haxe hxml neko
      julia node_js npm_args xcode_sdk xcode_scheme podfile xcode_project
      xcode_workspace xctool_args perl perl6 php composer_args python
      virtualenv r apt_packages bioc_packages bioc_required bioc_use_devel
      brew_packages cran disable_homebrew latex pandoc pandoc_version
      r_binary_packages r_build_args r_check_args r_check_revdep
      r_github_packages r_packages warnings_are_errors Remotes repos ruby
      gemfile bundler_args rust scala sbt_args smalltalk smalltalk_config
    )
  end

  it { expect(except(spec, :map)).to eq(name: :root, type: :map, expand: expand) }
  it { expect(map.keys).to eq keys }

  it { expect(map[:osx_image]).to eq key: :osx_image, types: [type: :scalar, edge: true] }
  it { expect(map[:source_key]).to eq key: :source_key, types: [type: :scalar, cast: [:secure]] }
end

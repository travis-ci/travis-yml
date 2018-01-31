require 'travis/yaml/spec/def/lang/worker_stacks'

describe Travis::Yaml::Spec, 'worker stacks' do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }

  Travis::Yaml::Spec::Def::Stack::VALUES.each do |stack|
    describe Travis::Yaml::Spec::Def, stack do
      it { expect(lang[:values]).to include(value: "__#{stack}__", deprecated: true) }
    end
  end
end

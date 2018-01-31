require 'travis/yaml/spec/def/lang/worker_stacks'

describe Travis::Yaml::Spec, :WORKER_STACKS do
  let(:spec)    { Travis::Yaml.spec }
  let(:support) { Travis::Yaml.support }
  let(:lang)    { spec[:map][:language][:types][0] }

  Travis::Yaml::Spec::WORKER_STACKS.each do |stack|
    describe Travis::Yaml::Spec::Def, stack do
      it { expect(lang[:values]).to include(value: "__#{stack}__", deprecated: true) }
    end
  end
end

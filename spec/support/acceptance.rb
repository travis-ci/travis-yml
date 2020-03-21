module Spec
  module Support
    module Acceptance
      def self.included(const)
        const.extend(ClassMethods)
      end

      module ClassMethods
        def accept(name, *args, &block)
          describe name, *args do
            shared_examples(name, &block)
            include_examples :acceptance, name
          end
        end
      end
    end
  end
end

RSpec.shared_examples :acceptance do |examples|
  describe Travis::Yml, context: :yml do
    subject { described_class.load(yaml, opts) }
    include_examples examples
  end

  describe Travis::Yml::Configs, context: :configs do
    let(:repo) { { github_id: 1, slug: 'travis-ci/travis-yml', private: false, token: 'token', private_key: 'key', allow_config_imports: true } }
    let(:data) { { branch: 'master' } }
    subject { described_class.new(repo, 'master', nil, data, opts).tap(&:load) }
    before { stub_content(repo[:github_id], '.travis.yml', yaml) }
    include_examples examples
  end
end

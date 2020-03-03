describe Travis::Yml, 'template', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'notifications.slack.template' do
    describe 'given a str' do
      yaml %(
        notifications:
          slack:
            template: str
      )
      it { should serialize_to notifications: { slack: [template: ['str']] } }
      it { should_not have_msg }
    end

    describe 'given a known var' do
      yaml %(
        notifications:
          slack:
            template: '%{repository}'
      )
      it { should serialize_to notifications: { slack: [template: ['%{repository}']] } }
      it { should_not have_msg }
    end

    describe 'given an unknown var' do
      yaml %(
        notifications:
          slack:
            template: '%{unknown}'
      )
      it { should serialize_to notifications: { slack: [template: ['%{unknown}']] } }
      it { should have_msg [:warn, :'notifications.slack.template', :unknown_var, var: 'unknown', line: 3] }
    end
  end
end

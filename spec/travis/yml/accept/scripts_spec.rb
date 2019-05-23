describe Travis::Yml, 'scripts' do
  subject { described_class.apply(parse(yaml), opts) }

  stages = %i(
    before_install
    install
    before_script
    script
    after_success
    after_failure
    after_script
    before_cache
    before_deploy
    after_deploy
  )

  stages.each do |stage|
    describe stage.to_s do
      describe 'given a string' do
        yaml %(
          #{stage}: ./foo
        )
        it { should serialize_to stage => ['./foo'] }
      end
    end
  end

  describe 'given a seq' do
    yaml %(
      script:
      - ./foo
      - ./bar
    )
    it { should serialize_to script: ['./foo', './bar'] }
    it { should_not have_msg }
  end

  describe 'given a seq with a num and a str' do
    yaml %(
      script:
      - 1
      - ./foo
    )
    it { should serialize_to script: ['1', './foo'] }
    it { should have_msg [:info, :script, :cast, given_value: 1, given_type: :num, type: :str, value: '1'] }
  end

  describe 'given a seq with a bool and a str' do
    yaml %(
      script:
      - true
      - ./foo
    )
    it { should serialize_to script: ['true', './foo'] }
    it { should have_msg [:info, :script, :cast, given_value: true, given_type: :bool, type: :str, value: 'true'] }
  end

  describe 'commented lines (from our docs?)' do
    yaml %(
      script:
      - one
      - # one
      - two
      - # two
    )
    it { should_not have_msg }
  end

  describe 'a str that parses into a map', drop: true do
    yaml %(
      script:
        - echo "== Foo: ==
        - ./script
    )

    it { should serialize_to script: ['./script'] }
    it { should have_msg [:error, :script, :invalid_type, expected: :str, actual: :map, value: { 'echo "== Foo': '==' }] }
  end

  # describe 'repairs a broken scalar that is parsed into a hash', v2: true, repair: true do
  #   yaml %(
  #     script:
  #     - curl -j -L -H "Cookie:cookie" $JAVA_URL > java/$JAVA_FILE
  #   )
  #   it { should serialize_to script: ['curl -j -L -H "Cookie:cookie" $JAVA_URL > java/$JAVA_FILE'] }
  #   it { should have_msg [:warn, :script, :repair, key: 'curl -j -L -H "Cookie', value: 'cookie" $JAVA_URL > java/$JAVA_FILE', to: 'curl -j -L -H "Cookie:cookie" $JAVA_URL > java/$JAVA_FILE'] }
  # end
  #
  # describe 'repairs a broken scalar that is parsed into a hash (2)', v2: true, repair: true do
  #   yaml %(
  #     script: 'sudo pip install --upgrade natcap.versioner>=0.3.1 --egg --no-binary :all:'
  #   )
  #   it { should serialize_to script: ['sudo pip install --upgrade natcap.versioner>=0.3.1 --egg --no-binary :all:'] }
  #   it { should have_msg [:warn, :script, :repair, key: key, value: nil, to: 'sudo pip install --upgrade natcap.versioner>=0.3.1 --egg --no-binary :all:'] }
  # end
end

describe Travis::Yaml, 'addon: artifacts' do
  let(:msgs)      { subject.msgs }
  let(:artifacts) { subject.serialize[:addons][:artifacts] }

  subject { described_class.apply(input) }

  describe 'options' do
    input = {
      bucket:       'bucket',
      key:          'key',
      secret:       'secret',
      paths:        'foo',
      branch:       'branch',
      log_format:   'format',
      target_paths: 'bar',
      debug:        true,
      concurrency:  '40',
      max_size:     '1024'
    }

    let(:input) { { addons: { artifacts: input } } }

    it { expect(artifacts[:bucket]).to       eq 'bucket' }
    it { expect(artifacts[:key]).to          eq 'key'    }
    it { expect(artifacts[:secret]).to       eq 'secret' }
    it { expect(artifacts[:paths]).to        eq ['foo']  }
    it { expect(artifacts[:branch]).to       eq 'branch' }
    it { expect(artifacts[:log_format]).to   eq 'format' }
    it { expect(artifacts[:target_paths]).to eq 'bar'    }
    it { expect(artifacts[:debug]).to        eq true     }
    it { expect(artifacts[:concurrency]).to  eq '40'     }
    it { expect(artifacts[:max_size]).to     eq '1024'   }
  end

  describe 'given true' do
    let(:input) { { addons: { artifacts: true } } }
    it { expect(artifacts).to eq enabled: true }
  end

  describe 'given true, and a misplaced key' do
    let(:input) { { addons: { artifacts: true, region: 'us-west-2' } } }
    it { expect(artifacts).to eq enabled: true, region: 'us-west-2' }
  end

  describe 'given true, and a misplaced, alias key' do
    let(:input) { { addons: { artifacts: true, s3_region: 'us-west-2' } } }
    it { expect(artifacts).to eq enabled: true, region: 'us-west-2' }
  end
end

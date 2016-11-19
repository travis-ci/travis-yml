describe Travis::Yaml, 'addon: artifacts' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'artifacts' do
    describe 'options' do
      config = {
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

      let(:config) { { addons: { artifacts: config } } }

      it { expect(addons[:artifacts][:bucket]).to       eq 'bucket' }
      it { expect(addons[:artifacts][:key]).to          eq 'key'    }
      it { expect(addons[:artifacts][:secret]).to       eq 'secret' }
      it { expect(addons[:artifacts][:paths]).to        eq ['foo']  }
      it { expect(addons[:artifacts][:branch]).to       eq 'branch' }
      it { expect(addons[:artifacts][:log_format]).to   eq 'format' }
      it { expect(addons[:artifacts][:target_paths]).to eq 'bar'    }
      it { expect(addons[:artifacts][:debug]).to        eq true     }
      it { expect(addons[:artifacts][:concurrency]).to  eq '40'     }
      it { expect(addons[:artifacts][:max_size]).to     eq '1024'   }
    end

    describe 'given true' do
      let(:config) { { addons: { artifacts: true } } }
      it { expect(addons[:artifacts]).to eq(enabled: true) }
    end
  end
end

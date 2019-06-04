describe Travis::Yml::Docs::Schema::Scalar do
  let(:root) { Travis::Yml::Docs::Schema::Factory.build(nil, Travis::Yml.schema) }

  subject { root[:dist] }

  it { should have_opt id: :dist }
  it { should have_opt title: 'Distribution' }
  it { should have_opt summary: 'Build environment distribution' }
  it { should have_opt type: :str }
  it { should have_opt downcase: true }
  it { should have_opt enum: %w(trusty precise xenial server-2016) }
end


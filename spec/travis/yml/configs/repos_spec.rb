# describe Travis::Yml::Import::Repos do
#   let(:repos) { described_class.new }
#   let(:threads) { 1.upto(5).map { Thread.new { repos['travis-ci/travis-yml'] } } }
#
#   before { stub_request(:get, /.*/) }
#   before { threads.join }
#
#   # for some reason this doesn't work. does WebMock count per thread?
#   # it { expect(WebMock).to have_requested(:get, /.*/).times(1) }
# end

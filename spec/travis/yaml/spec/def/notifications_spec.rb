describe Travis::Yaml::Spec::Def::Notifications do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :notifications,
      type: :map
    )
  end

  it do
    expect(spec[:map].keys).to eq %i(
      email
      campfire
      flowdock
      hipchat
      irc
      pushover
      slack
      webhooks
      on_success
      on_failure
    )
  end
end


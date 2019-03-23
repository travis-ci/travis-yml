describe Travis::Yaml::Spec::Def::Notifications do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map, :alias)).to eq(
      name: :notifications,
      type: :map,
      prefix: {
        key: :email,
        type: [:bool]
      }
    )
  end

  it do
    expect(spec[:map].keys).to eq %i(
      enabled
      disabled
      email
      campfire
      flowdock
      hipchat
      irc
      pushover
      slack
      webhooks
      on_start
      on_success
      on_failure
    )
  end
end


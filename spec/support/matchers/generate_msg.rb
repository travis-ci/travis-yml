RSpec::Matchers.define :generate_msg do |_|
  match do |msg|
    msg = Travis::Yml.msg(msg)
    expect(msg).to_not include 'unable to generate message'
  end
end

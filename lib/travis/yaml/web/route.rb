module Travis::Yaml::Web::Route
  def call(env)
    public_send(env['REQUEST_METHOD'.freeze].downcase, env)
  end

  private

  def method_missing(*)
    [404, {}, []]
  end
end

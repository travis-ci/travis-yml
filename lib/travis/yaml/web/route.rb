require 'oj'

module Travis::Yaml::Web::Route
  def call(env)
    public_send(env['REQUEST_METHOD'.freeze].downcase, env)
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def body(decorator, obj)
    [
      Oj.dump(decorator.new(obj).call)
    ]
  end

  private

  def method_missing(*)
    [404, {}, []]
  end
end

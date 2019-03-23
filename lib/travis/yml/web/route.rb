# frozen_string_literal: true
require 'oj'

module Travis::Yml::Web::Route
  def call(env)
    public_send(env['REQUEST_METHOD'].downcase, env)
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def body(decorator, obj)
    [
      Oj.dump(decorator.new(obj).call, mode: :strict)
    ]
  end

  private

  def method_missing(*)
    [404, {}, []]
  end
end

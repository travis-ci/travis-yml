# frozen_string_literal: true
require 'oj'

module Travis::Yaml::Web::Route
  def call(env)
    public_send(env['REQUEST_METHOD'.freeze].downcase, env)
  end

  def headers
    { 'Content-Type'.freeze => 'application/json'.freeze }
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

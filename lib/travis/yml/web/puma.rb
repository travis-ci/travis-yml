# frozen_string_literal: true
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

require 'travis/yml/web'

preload_app!

rackup      Puma::Configuration::DEFAULTS[:rackup]
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

before_fork do
  Travis::Yml.expand
end

lowlevel_error_handler do |error, env|
  Raven.capture_exception(
    error,
    message: error.message,
    extra: { puma: env },
    transaction: 'Puma'
  )
  [500, {}, ['{}']]
end

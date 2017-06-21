require 'sinatra'

module Checker
  class Application < Sinatra::Application
    get '/' do
      'Hello, world!'
    end
  end
end

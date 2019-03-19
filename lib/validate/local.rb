# frozen_string_literal: true
require 'validate/record/message'
require 'validate/record/repo'
require 'validate/record/request'
require 'validate/record/review'

# [Record::Message, Record::Repo, Record::Request].each do |const|
#   const.establish_connection('postgresql://localhost/travis_yaml')
# end

ActiveRecord::Base.establish_connection('postgresql://localhost/travis_yaml')

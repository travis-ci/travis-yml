# frozen_string_literal: true
require 'active_record'

module Record
  class Request < ActiveRecord::Base
    has_many :messages
    belongs_to :repo
  end
end

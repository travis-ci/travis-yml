# frozen_string_literal: true
require 'active_record'

module Record
  class Message < ActiveRecord::Base
    self.table_name = :messages

    belongs_to :repo
    belongs_to :request
    has_many :reviews

    serialize :args, JSON
  end
end

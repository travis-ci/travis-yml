# frozen_string_literal: true
require 'active_record'

module Record
  class Repo < ActiveRecord::Base
    has_many :messages

    def slug
      [owner_name, name].join('/')
    end
  end
end

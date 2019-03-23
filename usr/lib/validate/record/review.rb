# frozen_string_literal: true
require 'active_record'

module Record
  class Review < ActiveRecord::Base
    belongs_to :message
  end
end

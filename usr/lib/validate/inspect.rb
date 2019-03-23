# frozen_string_literal: true
require 'validate/msgs'
require 'validate/review'

class Inspect < Struct.new(:opts)
  include Msgs

  def run
    msgs.map do |msg|
      result, record, msg = *msg
      puts format(result, record.request_id, msg)
      puts
      config = LessYAML.load(Record::Request.find(record.request_id).config)
      part = only(config, record.key.split('.').first)
      puts part.empty? ? config : part
    end
  end

  private

    def msgs
      msgs = records.map { |msg| [Review.new(msg).result, msg, send(code, msg)] }
      msgs = msgs.sort_by { |msg| [SORT[msg[0] || :default], msg[2]].join }
      msgs = msgs.select { |msg| msg[2] == str } unless str.to_s.empty?
      msgs
    end

    def records
      Record::Message.where(code: code)
    end

    def code
      opts[:code]
    end

    def str
      opts[:str]
    end

    STATUS = {
      ok:      '✅',
      not_ok:  '❌',
      check:   '🤔',
      default: ' '
    }

    SORT = {
      not_ok: 1,
      check: 2,
      default: 3,
      ok: 4,
    }

    def format(result, id, str)
      status = STATUS[result] || STATUS[:default]
      "#{status} #{id.to_s.rjust(8)} [#{code}] #{str.to_s.gsub("\n", '\n')}"
    end

    def only(hash, *keys)
      hash.select { |key, _| keys.include?(key) }.to_h
    end
end


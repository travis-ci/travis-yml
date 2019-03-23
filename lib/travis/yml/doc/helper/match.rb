# frozen_string_literal: true
require 'amatch'
require 'travis/yml/support/obj'

module Travis
  module Yml
    class Match < Obj.new(:strs, :str)
      def run
        return if str.size < 3
        pairs = by_equality(strs)
        pairs = by_levenshtein(strs) if pairs.empty?
        pairs = by_permutation(strs) if pairs.empty? && str.size < 6
        pairs = by_letters(pairs.map(&:last)) if ambiguous?(pairs)
        pairs = by_length(pairs) if ambiguous?(pairs)
        pairs[0][1] unless pairs.empty?
      end

      def ambiguous?(pairs)
        return unless pairs.size > 1
        [pairs[0][0], pairs[1][0]].uniq.size == 1
      end

      def by_equality(strs)
        str = strs.detect { |str| str == self.str }
        str ? [[str]] : []
      end

      def by_levenshtein(strs)
        pairs = strs.map do |other|
          distance = Amatch::Levenshtein.new(other).match(str)
          [distance, other] if distance <= max && distance < 6
        end
        pairs = pairs.compact.sort_by(&:first)
        pairs
      end

      def by_permutation(strs)
        strs = strs.select { |other| other.size == size }
        key = strs.detect do |other|
          other.chars.permutation.to_a.map(&:join).include?(str)
        end
        key ? [[1, key]] : []
      end

      def by_letters(strs)
        pairs = strs.map do |other|
          chars = str.chars & other.chars
          [chars.size, other]
        end
        pairs.sort_by { |pair| 1000 - pair[0] }
      end

      def by_length(strs)
        strs.sort_by { |strs| 1000 - strs[1].size }
      end

      def size
        str.size
      end

      def max
        str.size.to_f / 3 # + 1
      end
    end
  end
end

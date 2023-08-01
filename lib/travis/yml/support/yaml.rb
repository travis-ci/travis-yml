# frozen_string_literal: true
require 'psych'
require 'yaml'
require 'travis/yml/support/key'
require 'travis/yml/support/map'
require 'travis/yml/support/seq'

# YAML.singleton_class.undef_method(:load)

Psych.add_tag('!map+replace', Map)
Psych.add_tag('!map+merge', Map)
Psych.add_tag('!map+merge+append', Map)
Psych.add_tag('!map+deep_merge', Map)
Psych.add_tag('!map+deep_merge+prepend', Map)
Psych.add_tag('!map+deep_merge+append', Map)
Psych.add_tag('!seq+prepend', Seq)
Psych.add_tag('!seq+append', Seq)

module Yaml
  extend self

  def load(yaml)
    return false unless node = parse(yaml)
    loader = Loader.new(['Map', 'Seq', 'Symbol'], [])
    scanner = ScalarScanner.new(loader)
    visitor = Visitor.new(scanner, loader)
    visitor.accept(node)
  end

  def parse(yaml)
    parser = Parser.new(Handler.new { |node| return node })
    parser.parse(yaml)
    false
  end

  Loader = Psych::ClassLoader::Restricted
  Parser = Psych::Parser

  class Psych::Nodes::Node
    attr_accessor :anchors, :warnings
  end

  class Handler < Psych::Handlers::DocumentStream
    attr_accessor :last_scalar, :anchors

    def anchors
      @anchors ||= []
    end

    # def warnings
    #   @warnings ||= []
    # end

    def scalar(value, anchor, *args)
      anchors << last_scalar if anchor
      @last_scalar = value
      super
    end

    %i(mapping sequence).each do |type|
      define_method(:"start_#{type}") do |anchor, *args|
        anchors << last_scalar if anchor
        super(anchor, *args)
      end

      define_method(:"end_#{type}") do
        node = super()
        unique_keys(node) if type == :mapping
        node.anchors = anchors
        node
      end
    end

    def unique_keys(node)
      keys = node.children.each_slice(2).map(&:first)
      keys = keys.select { |node| node.respond_to?(:value) }
      keys = keys.map(&:value) - ['<<']
      dups = keys.select { |key| keys.count(key) > 1 }.uniq
      msgs = dups.map { |key| "Duplicate key #{key}" }
      node.warnings = msgs if msgs.any?
    end
  end

  class ScalarScanner < Psych::ScalarScanner
    KEEP = /yes|no|on|off/

    def tokenize(str)
      case str
      when FLOAT then str
      when KEEP  then str
      when TIME  then str
      else super
      end
    end
  end

  class Visitor < Psych::Visitors::ToRuby
    # ToRuby#revive_hash does not differentiate between keys and values. Maybe
    # make a PR to add ToRuby#accept_key, so we can hook in there.
    def visit_Psych_Nodes_Mapping(node)
      map = node.children.each_slice(2)
      map = map.map { |key, node| [to_key(key), node] }
      node.children.replace(map.flatten(1))
      super
    end

    def visit_Psych_Nodes_Scalar(node)
      node.tag = nil if node.tag.to_s.start_with?('!ruby/')
      scalar = super
      scalar.is_a?(Symbol) ? scalar.to_s : scalar
    end

    def visit_Psych_Nodes_Sequence(node)
      Seq.new(super, node)
    end

    def to_key(node)
      raise unacceptable_key(node) unless node.respond_to?(:value)
      key = node.value.to_s
      key = key[1..-1] if key[0] == ':'
      node.value = Key.new(key, node.start_line)
      node
    end

    def revive_hash(hash, node, tagged = false)
      hash = Map.new(super, node)
      hash.opts[:anchors] = node.anchors if node.anchors&.any?
      hash.opts[:warnings] = node.warnings if node.warnings&.any?
      hash
    end

    def deduplicate key
      if key.is_a?(String) && !key.is_a?(Key)
        -key
      else
        key
      end
     end

    def deserialize(node)
      node.value.is_a?(Key) ? node.value : super
    end

    # Psych has started to raise on bad aliases in 2011, but apparently
    # SafeYAML has hidden this. So we hide it, too, for now, in order to not
    # break anyone's builds.
    def visit_Psych_Nodes_Alias(node)
      # Psych's implementation
      # @st.fetch(o.anchor) { raise BadAlias, "Unknown alias: #{o.anchor}" }
      @st[node.anchor]
    end

    def unacceptable_key(node)
      Psych::SyntaxError.new(nil, node.start_line, node.start_column, nil, "unacceptable key (#{node.class.name.split('::').last.downcase})", nil)
    end
  end
end

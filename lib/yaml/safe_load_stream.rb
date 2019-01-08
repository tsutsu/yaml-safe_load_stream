# frozen_string_literal: true

require 'yaml'

module YAMLSafeLoadStream
  # A safe version of YAML.load_stream.
  # Parses a multi document stream and raises if it tries to instantiate any
  # non-standard classes
  #
  # @param yaml [String] yaml content
  # @param filename [String] filename to be used in exception messages
  # @yield [document] each document in the stream is yielded if a block is given
  # @return [Array] when a block is not given, returns an Array of documents
  module_function def safe_load_stream(yaml, filename = nil)
    result = []
    ::YAML.parse_stream(yaml, filename) do |stream|
      raise_if_tags(stream, filename)
      result << if block_given?
                  yield(stream.to_ruby)
                else
                  stream.to_ruby
                end
    end
    result
  end

  module_function def raise_if_tags(obj, filename = nil, doc_num = 1)
    doc_num += 1 if obj.is_a?(Psych::Nodes::Document)

    if obj.respond_to?(:tag)
      tag = obj.tag
      unless tag.nil?
        unless tag.to_s.start_with?('tag:yaml.org,')
          message = "tag #{tag} encountered "
          message += if obj.respond_to?(:start_line)
                       "on line #{obj.start_line} column #{obj.start_column} of document #{doc_num}"
                     else
                       "in document #{doc_num}"
                     end
          message += " in file #{filename}" if filename
          raise Psych::DisallowedClass, message
        end
      end
    end

    return unless obj.respond_to?(:children)

    Array(obj.children).each do |child|
      raise_if_tags(child, filename, doc_num)
    end
  end
  private_class_method :raise_if_tags

  refine ::YAML.singleton_class do
    def safe_load_stream(*args, &block)
      ::YAMLSafeLoadStream.safe_load_stream(*args, &block)
    end
  end
end

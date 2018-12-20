# frozen_string_literal: true

require 'yaml'
require 'yaml/safe_load_stream'

module YAML
  def self.safe_load_stream(*args, &block)
    YAMLSafeLoadStream.safe_load_stream(*args, &block)
  end
end

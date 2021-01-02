# YAMLSafeLoadStream provided by `yaml-safe_load_stream2`
[![Gem Version](https://badge.fury.io/rb/yaml-safe_load_stream2.svg)](https://badge.fury.io/rb/yaml-safe_load_stream2)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/tsutsu/yaml-safe_load_stream2/master)

### Before you begin...

The `yaml-safe_load_stream2` project is a fork of
[kontena/k8s-client](https://github.com/kontena/yaml-safe_load_stream).

Unfortunately the company
[Kontena.io went bankcrupt](https://blog.kontena.io/farewell/) at
the end of the year 2019. They had created many wonderful Ruby projects which we
are grateful.

The `yaml-safe_load_stream2` library is a community effort to keep
`yaml-safe_load_stream` maintained without any dependencies to the former
Kontena.io organization. The library was renamed in order to publish it to
Rubygems without conflicting with `yaml-safe_load_stream`.

## Abstract

The Ruby standard library YAML/Psych module defines `YAML.safe_load` for safely loading YAML documents

There's also `YAML.load_stream` for loading multi-document streams.

The problem is, there's no `YAML.safe_load_stream` that would safely load a stream with multiple documents.

This gem adds a very bare bones implementation of that missing feature.

## Usage

There is just one method: `safe_load_stream(yaml_content, optional_filename_to_be_used_in_exception_messages)`

When used with a block, it will yield each document separately:

```ruby
YAMLSafeLoadStream.safe_load_stream("---\nhello: world\n\n---\nhello: universe\n") do |document|
  puts document.inspect
end

# outputs:
# { 'hello' => 'world' }
# { 'hello' => 'universe' }
```

When used without a block, it will return an Array containing documents in the stream:

```ruby
docs = YAMLSafeLoadStream.safe_load_stream("---\nhello: world\n\n---\nhello: universe\n")
puts docs.inspect

# outputs:
# [{ 'hello' => 'world' }, { 'hello' => 'universe' }]
```

### Directly

```ruby
require 'yaml/safe_load_stream'

YAMLSafeLoadStream.safe_load_stream("---\nhello: world\n\n---\nhello: universe\n")
```

### As a refinement

```ruby
require 'yaml/safe_load_stream'
using YAMLSafeLoadStream

YAML.safe_load_stream("---\nhello: world\n\n---\nhello: universe\n")
```

### Requiring the `core-ext`

```ruby
require 'yaml/safe_load_stream/core-ext'
YAML.safe_load_stream("---\nhello: world\n\n---\nhello: universe\n")
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaml-safe_load_stream2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaml-safe_load_stream2

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tsutsu/yaml-safe_load_stream2

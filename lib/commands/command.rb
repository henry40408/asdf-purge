#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'optparse'

def ignore_parents(dir)
  Dir.entries(File.expand_path(dir)).reject{ |entry| entry == '.' || entry == '..' }
end

def read_tool_versions
  plugins = []
  File.open(File.expand_path("~/.tool-versions")) do |f|
    f.each do |line|
      plugin, *versions = line.split(/\s+/)
      plugins << [plugin, versions]
    end
  end
  plugins
end

def main
  options = {}
  OptionParser.new do |opts|
    opts.on('-f', '--[no-]force', 'Purge')
    opts.on('-h', '--help', 'Help') do |_h|
      puts opts
      exit
    end
  end.parse!(into: options)

  tuples = []
  read_tool_versions.each do |(plugin, versions)|
    versions.each do |version|
      tuples << [plugin, version]
    end
  end

  plugins = tuples.map(&:first).uniq

  ignore_parents("~/.asdf/installs").each do |plugin|
    preserve_plugin = plugins.include?(plugin)
    ignore_parents("~/.asdf/installs/#{plugin}").each do |version|
      next if preserve_plugin && tuples.include?([plugin, version])
      full_path = File.expand_path("~/.asdf/installs/#{plugin}/#{version}")
      FileUtils.remove_dir(full_path, true) if options[:force]
      puts "- #{full_path}"
    end
  end
end

main

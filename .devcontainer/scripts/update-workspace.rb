#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates discourse.code-workspace with all git-cloned plugin repos as workspace folders.
# Run manually after cloning a new plugin:
#   .devcontainer/scripts/update-workspace.rb

require "json"

root = File.expand_path("../..", __dir__)
sample_path = File.join(root, ".devcontainer/discourse.code-workspace.sample")
workspace_path = File.join(root, "discourse.code-workspace")

plugin_folders =
  Dir
    .glob("#{root}/plugins/*/")
    .select { |dir| File.directory?("#{dir}/.git") }
    .sort
    .map { |dir| { "name" => File.basename(dir), "path" => "plugins/#{File.basename(dir)}" } }

workspace = JSON.parse(File.read(sample_path))
workspace["folders"] = [{ "name" => "discourse", "path" => "." }] + plugin_folders
File.write(workspace_path, "#{JSON.pretty_generate(workspace)}\n")

puts "Workspace updated: discourse + #{plugin_folders.length} plugin(s)"
plugin_folders.each { |f| puts "  - #{f["name"]}" }

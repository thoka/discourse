#!/usr/bin/env ruby
# frozen_string_literal: true

puts "👋 Welcome to the Discourse devcontainer! Let's get everything ready..."

puts "Setting permissions on volume mounts..."
system "sudo chown discourse .", exception: true
system "sudo chown discourse node_modules", exception: true
system "sudo chown -R postgres /shared/postgres_data", exception: true
system "sudo ln -sf #{File.expand_path(".devcontainer/scripts/chrome_wrapper", Dir.pwd)} /usr/bin/google-chrome",
       exception: true

puts "Starting services..."
fork do
  Process.daemon
  exec "sudo nohup /sbin/boot"
end

system "cp -n .vscode/settings.json.sample .vscode/settings.json", exception: true
system "cp -n .vscode/tasks.json.sample .vscode/tasks.json", exception: true

puts "Generating workspace file..."
require "json"
sample_path = File.expand_path(".devcontainer/discourse.code-workspace.sample", Dir.pwd)
workspace_path = File.expand_path("discourse.code-workspace", Dir.pwd)
plugin_folders =
  Dir
    .glob("plugins/*/")
    .select { |dir| File.directory?("#{dir}/.git") }
    .sort
    .map { |dir| { "name" => File.basename(dir), "path" => dir.chomp("/") } }
workspace = JSON.parse(File.read(sample_path))
workspace["folders"] = [{ "name" => "discourse", "path" => "." }] + plugin_folders
File.write(workspace_path, "#{JSON.pretty_generate(workspace)}\n")
puts "Workspace: discourse + #{plugin_folders.length} plugin(s)"

puts "Prüfe Ruby Gems..."
system "bundle check || bundle install --jobs 4", exception: true

puts <<~TXT
  🎉 All done!

  Next steps:
    1. Cmd/Ctrl + Shift + B to run the shortcuts/boot-dev task
    2. Wait for the server to start
    3. Open your browser to http://localhost:4200
TXT

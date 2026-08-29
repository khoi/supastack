#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

plugin_root = File.expand_path("..", __dir__)
skills_root = File.join(plugin_root, "skills")
problems = []

def frontmatter(path)
  match = File.read(path).match(/\A---\s*\n(.*?)\n---\s*\n/m)
  raise "missing frontmatter: #{path}" unless match

  YAML.safe_load(match[1], aliases: false) || {}
end

skill_names = Dir.children(skills_root).select do |name|
  File.file?(File.join(skills_root, name, "SKILL.md"))
end
problems << "expected 37 skills, found #{skill_names.length}" unless skill_names.length == 37
required_names = %w[poteto-mode setup-supastack supastack]
missing_names = required_names - skill_names
problems << "missing required skills: #{missing_names.join(', ')}" unless missing_names.empty?

skill_names.sort.each do |name|
  skill_dir = File.join(skills_root, name)
  skill_file = File.join(skill_dir, "SKILL.md")
  metadata = frontmatter(skill_file)
  problems << "#{skill_file}: name must be #{name}" unless metadata["name"] == name
  unsupported = metadata.keys - %w[name description metadata]
  problems << "#{skill_file}: unsupported frontmatter: #{unsupported.join(', ')}" unless unsupported.empty?

  policy_path = File.join(skill_dir, "agents", "openai.yaml")
  if File.file?(policy_path)
    policy = YAML.safe_load(File.read(policy_path), aliases: false) || {}
    unless policy.dig("policy", "allow_implicit_invocation") == false
      problems << "#{name}: agents/openai.yaml must set allow_implicit_invocation to false"
    end
  end
end

forbidden = {
  /(?:\A|\W)\.cursor\// => ".cursor path",
  %r{~/\.cursor} => "personal Cursor path",
  /cursor-team-kit/i => "cursor-team-kit",
  /\bCursor(?:'s|\s)/ => "Cursor product instruction",
  /\bAskQuestion\b/ => "AskQuestion",
  /\bcreate-skill\b/ => "create-skill",
  /\bTask tool\b/ => "Task tool",
  /`Task`/ => "Task primitive",
  /\bsubagent_type\b/ => "subagent_type",
  /\brun_in_background\b/ => "run_in_background",
  /`\/(?:goal|loop|automate|deslop|no-comments|technical-writing|unslop)`/ => "Cursor slash invocation",
  /["'`]\/(?:architect|reflect|poteto-mode|how|why|swarm|interrogate)\b/ => "Cursor slash skill invocation",
  /compatibility\// => "compatibility layer reference",
  /\bpstack\b/i => "legacy product name",
  %r{(?:\A|\W)vendor/} => "legacy vendor path"
}

Dir.glob(File.join(skills_root, "**", "*.{md,yaml,toml}")).sort.each do |path|
  File.foreach(path).with_index(1) do |line, number|
    forbidden.each do |pattern, label|
      problems << "#{path}:#{number}: #{label}" if line.match?(pattern)
    end
  end
end

playbook_names = Dir.glob(File.join(skills_root, "poteto-mode", "playbooks", "*.md")).map do |path|
  File.basename(path)
end
problems << "expected 23 playbook files, found #{playbook_names.length}" unless playbook_names.length == 23
problems << "missing Opening a PR delivery helper" unless playbook_names.include?("opening-a-pr.md")
routable_count = (playbook_names - ["opening-a-pr.md"]).length
problems << "expected 22 routable playbooks, found #{routable_count}" unless routable_count == 22

if problems.empty?
  puts "skill package valid: 37 skills, 22 routable playbooks, 1 delivery helper"
  exit 0
end

warn problems.join("\n")
exit 1

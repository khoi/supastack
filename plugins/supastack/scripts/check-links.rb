#!/usr/bin/env ruby
# frozen_string_literal: true

require "pathname"
require "uri"

root = Pathname.new(ARGV.fetch(0, File.expand_path("..", __dir__))).expand_path
problems = []

root.glob("**/*.md").sort.each do |markdown|
  fenced = false
  markdown.each_line.with_index(1) do |line, number|
    fenced = !fenced if line.lstrip.start_with?("```")
    next if fenced

    line.scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |raw_target|
      target = raw_target.strip.sub(/\A</, "").sub(/>\z/, "")
      next if target.empty? || target.start_with?("#")
      next if %w[url URL path].include?(target)
      next if target.match?(%r{\A(?:https?|mailto|codex):})
      next if target.include?("{{") || target.include?("<")

      path_part = target.split("#", 2).first.split("?", 2).first
      begin
        path_part = URI.decode_www_form_component(path_part)
      rescue ArgumentError
        problems << "#{markdown}:#{number}: invalid link encoding: #{target}"
        next
      end
      resolved = markdown.dirname.join(path_part).cleanpath
      problems << "#{markdown}:#{number}: missing local link: #{target}" unless resolved.exist?
    end
  end
end

if problems.empty?
  puts "local Markdown links valid"
  exit 0
end

warn problems.join("\n")
exit 1

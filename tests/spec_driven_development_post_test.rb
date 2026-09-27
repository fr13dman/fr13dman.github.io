#!/usr/bin/env ruby
# frozen_string_literal: true

# Checks the spec-driven development post has the front matter the README requires.
# Run from the repo root: ruby tests/spec_driven_development_post_test.rb

path = File.expand_path("../_posts/2026-09-26-spec-driven-development-with-github-spec-kit.md", __dir__)
abort "missing post: #{path}" unless File.file?(path)

contents = File.read(path)
abort "post is missing front matter" unless contents.start_with?("---\n")

front_matter = contents.split(/^---\s*$/, 3)[1]
abort "post front matter did not close" if front_matter.nil? || front_matter.empty?

required = {
  "layout" => "post",
  "title" => '"Spec-driven development with GitHub Spec Kit"',
  "categories" => "[blog, software-engineering, ai]",
  "description" => nil
}

required.each do |key, expected|
  line = front_matter.lines.find { |entry| entry.start_with?("#{key}:") }
  abort "missing front matter key: #{key}" unless line
  next if expected.nil?

  value = line.split(":", 2).last.strip
  abort "expected #{key} to be #{expected}, got #{value}" unless value == expected
end

%w[tags keywords].each do |key|
  abort "missing front matter list: #{key}" unless front_matter.match?(/^#{key}:\s*$/)
end

date_line = front_matter.lines.find { |entry| entry.start_with?("date:") }
abort "missing date" unless date_line
date_value = date_line.split(":", 2).last.strip
abort "date should start with 2026-09-26" unless date_value.start_with?("2026-09-26")

body = contents.split(/^---\s*$/, 3)[2].to_s
%w[speckit-specify speckit-plan speckit-tasks speckit-implement speckit-converge].each do |command|
  abort "body missing #{command}" unless body.include?(command)
end

puts "ok: spec-driven development post front matter"

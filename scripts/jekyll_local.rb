# frozen_string_literal: true

# Jekyll 3.9, as pinned by github-pages, uses absolute Windows glob paths
# internally. Ruby 4.0.5 on this machine returns no matches for those patterns,
# so local builds need a tiny compatibility shim before Jekyll boots.
module AbsoluteWindowsGlobCompat
  def [](*args, base: nil, sort: true)
    matches = super(*args, base: base, sort: sort)
    matches.empty? ? fallback(args.first) : matches
  end

  def glob(pattern, *args, **kwargs, &block)
    matches = super
    matches = fallback(pattern) if matches.empty?

    if block
      matches.each(&block)
      nil
    else
      matches
    end
  end

  private

  def fallback(pattern)
    return [] unless pattern.is_a?(String)
    return [] unless pattern.match?(/\A[A-Za-z]:[\/\\]/)

    return [pattern] if File.exist?(pattern)
    return brace_matches(pattern) if pattern.include?("{_,}")
    return recursive_ruby_matches(pattern) if pattern.include?("**") && pattern.end_with?("*.rb")

    directory = File.dirname(pattern)
    return [] unless File.directory?(directory)

    return [] unless pattern.end_with?("*.rb")

    entries = Dir.children(directory).select { |entry| File.extname(entry) == ".rb" }
    paths = entries.map { |entry| File.join(directory, entry) }.sort

    paths
  end

  def recursive_ruby_matches(pattern)
    root = pattern.split("**", 2).first
    root = File.dirname(root) if root.end_with?("/", "\\")
    return [] unless File.directory?(root)

    Dir.children(root).flat_map do |entry|
      path = File.join(root, entry)
      if File.directory?(path)
        Dir.glob(File.join(path, "**", "*.rb"))
      elsif File.extname(path) == ".rb"
        path
      else
        []
      end
    end.sort
  end

  def brace_matches(pattern)
    expanded = [pattern.gsub("{_,}", "_"), pattern.gsub("{_,}", "")]
    expanded.select { |path| File.exist?(path) }.sort
  end
end

class << Dir
  prepend AbsoluteWindowsGlobCompat
end

class Object
  def tainted?
    false
  end unless method_defined?(:tainted?)

  def untaint
    self
  end unless method_defined?(:untaint)
end

def local_env_overlay_available?
  root = File.expand_path("..", __dir__)
  env_file = File.join(root, ".env")
  overlay_file = File.join(root, ".jekyll-env.yml")
  writer = File.join(__dir__, "write_env_config.rb")

  system(RbConfig.ruby, writer) if File.file?(writer) && File.file?(env_file)

  File.file?(overlay_file)
end

def config_option_present?
  ARGV.include?("--config") || ARGV.any? { |arg| arg.start_with?("--config=") }
end

if local_env_overlay_available? && !config_option_present?
  ARGV << "--config" << "_config.yml,.jekyll-env.yml"
end

require "bundler/setup"
load Gem.bin_path("jekyll", "jekyll")

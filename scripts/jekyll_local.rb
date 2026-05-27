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

    directory = File.dirname(pattern)
    return [] unless File.directory?(directory)

    return [] unless pattern.end_with?("*.rb")

    entries = Dir.children(directory).select { |entry| File.extname(entry) == ".rb" }
    paths = entries.map { |entry| File.join(directory, entry) }.sort

    paths
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

require "bundler/setup"
load Gem.bin_path("jekyll", "jekyll")

# frozen_string_literal: true

require "yaml"

DEFAULT_MANIFEST_PATH = "config/env.yml"
DEFAULT_DOTENV_PATH = ".env"
DEFAULT_OUTPUT_PATH = ".jekyll-env.yml"

manifest_path = ARGV.fetch(0, DEFAULT_MANIFEST_PATH)
output_path = ARGV.fetch(1, DEFAULT_OUTPUT_PATH)

def parse_dotenv(path)
  return {} unless File.file?(path)

  File.readlines(path, chomp: true).each_with_object({}) do |line, values|
    stripped = line.strip
    next if stripped.empty? || stripped.start_with?("#")

    key, raw_value = stripped.split("=", 2)
    next if key.nil? || key.strip.empty?

    normalized_key = key.strip
    value = clean_dotenv_value(raw_value || "")
    next if values.key?(normalized_key) && !values[normalized_key].empty?

    values[normalized_key] = value
  end
end

def clean_dotenv_value(value)
  stripped = value.strip
  quote = stripped[0]

  if quote && (quote == '"' || quote == "'") && stripped.end_with?(quote)
    stripped[1...-1]
  else
    stripped
  end
end

def env_value(name, dotenv_values)
  value = dotenv_values[name]
  value = ENV[name] if value.nil? || value.empty?
  return nil if value.nil? || value.empty?

  value
end

def set_nested(config, path, value)
  return if value.nil?

  keys = path.to_s.split(".")
  cursor = config

  keys[0...-1].each do |key|
    cursor[key] ||= {}
    cursor = cursor[key]
  end

  cursor[keys.last] = value
end

manifest = YAML.load_file(manifest_path)
dotenv_values = parse_dotenv(DEFAULT_DOTENV_PATH)
config = {}
missing_required = []
strict_mode = ENV["STRICT_ENV_CONFIG"] == "1"

Array(manifest).each do |entry|
  env_name = entry.fetch("env")
  config_path = entry.fetch("path")
  required = entry["required"] == true

  value = env_value(env_name, dotenv_values)
  missing_required << env_name if strict_mode && required && value.nil?

  set_nested(config, config_path, value)
end

unless missing_required.empty?
  raise "Missing required environment values: #{missing_required.join(', ')}"
end

File.write(output_path, config.to_yaml)

require 'modalsettings'
require 'yaml'

# Global settings class
class Settings
  def self.load(filename, _root = nil)
    s = self[YAML.load_file filename]
    s
  end

  def key?(key)
    @table.key?(key)
  end

  def keys
    @table.keys
  end

  def select(&block)
    @table.select(&block)
  end
end

def settings
  # rubocop:disable Style/GlobalVars
  $settings ||= Settings.load 'config.yml'
end

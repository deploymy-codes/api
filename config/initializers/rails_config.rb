RailsConfig.setup do |config|
  config.const_name = "Constants"
end

files = Dir[Rails.root.join("config/constants/*.yml")]
RailsConfig.load_and_set_settings(files)

# Load the Rails application.
require File.expand_path('../application', __FILE__)
GOOGLE_API_KEYS = YAML.load_file(File.join(Rails.root, "config", "google-api-keys.yml"))[Rails.env]
# Initialize the Rails application.
GlassTodo::Application.initialize!

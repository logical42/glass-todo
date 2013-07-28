Rails.application.routes.default_url_options[:host] = 'localhost:3000' if Rails.env.development?

Glass.setup do |config|
  config.application_name = "Glass Todo"
  config.application_version = "0.0.1"


  ## manually override your glass views path here.
  config.glass_template_path = "app/views/glass"
end





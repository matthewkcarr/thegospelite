# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TheGospelite::Application.initialize!
Mime::Type.register 'audio/mpeg', :mp3
Mime::Type.register 'audio/mp4a-latm', :m4a
#Mime::Type.register 'application/zip', :zip

TheGospelite::Application.configure do
  config.assets.paths << Rails.root.join("app", "assets", "fonts")
end

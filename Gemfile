source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.rc1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# gems for app
gem 'devise'
gem 'pundit'
# ??
gem 'auto_html'
gem 'acts_as_votable'

# gems for design
gem 'font-awesome-rails'
gem 'bourbon'
gem 'neat'
gem 'refills'
gem 'normalize-rails'

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # security check
  gem 'brakeman'
  # brakeman
  gem 'rubycritic'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem 'rspec-rails'
  # rails generate rspec:install
  # easier model tests (inside rspec)
  gem 'shoulda-matchers' # , '~> 3.1'
  # FEATURE TESTS
  gem 'cucumber-rails', require: false
  # rails generate cucumber:install
  # https://github.com/cucumber/cucumber/wiki/RSpec-Expectations
  # use rspec - expectations in cucumber
  gem 'rspec-expectations'
  # database_cleaner is not required, but highly recommended
  # gem 'database_cleaner'
  # allow cucumber to do JavaScript testing too
  gem 'selenium-webdriver'
  # https://mikecoutermarsh.com/rails-capybara-selenium-chrome-driver-setup/
  # download chromedriver from: http://chromedriver.chromium.org/
  # or use brew cask install chromedriver
  # finally in features/env.rb - switch the browser to :chrome
  # gem 'chromedriver-helper'
  gem 'webdrivers' # , '~> 3.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'faker'
  gem 'factory_bot_rails'
end

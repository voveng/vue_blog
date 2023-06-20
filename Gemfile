# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'


gem 'rails', '~> 7.0.4', '>= 7.0.4.3'


gem 'pg', '~> 1.1'


gem 'puma', '~> 5.0'


gem 'redis', '~> 4.0'


gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]


gem 'bootsnap', require: false

gem 'active_interaction', '~> 5.3'
gem 'bcrypt'
gem 'rack-cors'
gem 'jwt'

gem 'rubocop', require: false
gem 'rubocop-performance', require: false

gem 'rspec-rails'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'faker'
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'capybara-email'
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

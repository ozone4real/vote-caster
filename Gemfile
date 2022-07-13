source 'http://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'sinatra'
gem 'bootstrap'
# gem 'sinatra-assets', :require => 'sinatra/assets'
gem 'activerecord', '~> 7.0.3'
gem 'activesupport', '~> 7.0.3'
gem 'uglifier'
# gem 'padrino-helpers'
gem 'sinatra-activerecord'
gem 'sprockets-helpers'
gem 'sass', '~> 3.4', '>= 3.4.22'
gem 'font-awesome-sass', '~> 5.11', '>= 5.11.2'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'sinatra-flash'
gem 'bcrypt'
gem 'i18n'
gem 'tux'
gem 'mysql2', '~> 0.5.2'
gem 'sinatra-contrib', :require => 'sinatra/respond_with'
gem 'actionview', :require => 'action_view/helpers'
# gem 'chosen'
# gem 'turbolinks', '~> 5.2.0

group :development, :test do
  gem 'shotgun'
  gem 'rerun'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'mysql2', '~> 0.5.2'
end

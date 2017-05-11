source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt', platforms: :ruby
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'chartkick'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'httparty', '~> 0.14.0'
gem 'iterate'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'normalize-scss', '~> 6.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rack-mini-profiler'
gem 'rails', '~> 5.0.2'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'sugar_refinery', require: 'sugar_refinery/all'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'database_cleaner'
  gem "factory_girl_rails", "~> 4.0", require: false
  gem 'ffaker'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5'
  gem 'simple_bdd'
end

group :development do
  gem "better_errors"
  gem 'rubocop', require: false
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

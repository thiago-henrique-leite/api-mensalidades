# rubocop:disable Lint/MissingCopEnableDirective, Style/FrozenStringLiteralComment

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'cpf_cnpj'
gem 'http', '~> 4.0'
gem 'kaminari'
gem 'pg', '~> 1.1'
gem 'pry-rails'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'settingslogic'
gem 'validates_cpf_cnpj'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec'
  gem 'rspec-collection_matchers'
  gem 'rspec-json_expectations'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rspec-retry'
end

group :development do
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'ffaker'
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.7.0'
  gem 'rubocop-performance', '~> 1.7.0'
  gem 'rubocop-rails', '~> 2.7.1'
  gem 'spring'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

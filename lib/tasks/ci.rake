# frozen_string_literal: true

require 'brakeman'
require 'rails_best_practices'
require 'rspec'
require 'rubocop/rake_task'

namespace :ci do
  desc 'Run tests on CI'
  task test: :environment do
    echo('>>>>> test <<<<<<<')
    sh('bundle exec rspec')
  end

  desc 'Run rails best practices on CI'
  task rails_best_practices: :environment do
    echo('>>>>> rails_best_practices <<<<<<<')
    sh('bundle exec rails_best_practices')
  end

  desc 'Run rubocop on CI'
  task rubocop: :environment do
    echo('>>>>> rubocop <<<<<<<')
    sh('bundle exec rubocop')
  end

  desc 'Run brakeman on CI'
  task brakeman: :environment do
    echo('>>>>> brakeman <<<<<<<')
    sh('bundle exec brakeman')
  end

  desc 'Run bundler-audit on CI'
  task bundler_audit: :environment do
    echo('>>>>> bundler_audit <<<<<<<')
    sh('bundle exec bundle-audit check --update')
  end

  desc 'default CI tasks'
  task default: %i[rails_best_practices rubocop brakeman bundler_audit test]
end

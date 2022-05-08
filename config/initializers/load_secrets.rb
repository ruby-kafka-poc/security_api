# frozen_string_literal: true

SECRETS = YAML.load_file(Rails.root.join('config/secrets.yml'))[Rails.env]

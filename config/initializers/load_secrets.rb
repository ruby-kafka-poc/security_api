# frozen_string_literal: true

begin
  SECRETS = YAML.load_file(Rails.root.join('config/secrets.yml'))[Rails.env]
rescue
  SECRETS = { jwt_key: 'unsecure. git-secrets not working?' }
end

# frozen_string_literal: true

require 'kafka_rails_integration'

class User < ApplicationRecord
  extend KafkaRailsIntegration::Concerns::Model::Eventeable

  eventeable(except: :password_digest)

  has_secure_password

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  before_save { self.email = email.downcase.strip }
end

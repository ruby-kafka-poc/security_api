# frozen_string_literal: true

class Security
  ALGORITHM = 'HS256'
  EXPIRATION = 4 * 3600 # 4 hours

  def self.encode(user_id, email)
    exp = Time.now.to_i + EXPIRATION
    payload = { user_id:, email:, exp: }
    JWT.encode(payload, SECRETS['jwt_key'], ALGORITHM)
  end

  # header: { 'Authorization': 'Bearer <token>' }
  def self.decode(auth_header)
    match_data = Regexp.new(/^Bearer (.*)$/).match(auth_header)
    return unless match_data

    begin
      JWT.decode(match_data[1], SECRETS['jwt_key'], true, algorithm: ALGORITHM)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end
  end
end

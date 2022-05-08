# frozen_string_literal: true

class Security
  def self.encode(user_id, email)
    JWT.encode({
                 user_id:,
                 email:
               }, SECRETS['jwt_key'])
  end

  # header: { 'Authorization': 'Bearer <token>' }
  def self.decode(auth_header)
    match_data = Regexp.new(/^Bearer (.*)$/).match(auth_header)
    return unless match_data

    begin
      JWT.decode(match_data[1], SECRETS['jwt_key'], true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
end

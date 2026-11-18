require "securerandom"

class JwtService
  ALGORITHM = "HS256"

  def self.encode(payload , exp = 120.minutes.from_now)
    payload[:jti] = SecureRandom.uuid
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key , ALGORITHM)
  end
  
  def self.secret_key
    Rails.application.secret_key_base
    # "hfbihdfowerhioweenwfjof46684687sfgsfhsiufghsufhiusygusgfsg"
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, secret_key, true, algorithm: ALGORITHM)
    decoded_token[0]
    # puts "Decoded Token: #{decoded_token}"  
  end
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.dig(:google, :client_id),
           Rails.application.credentials.dig(:google, :client_secret),
           {
             scope: "openid,email,profile",
             prompt: "select_account",
             callback_path: "/auth/google/callback"
           }
end

OmniAuth.config.request_validation_phase =
  OmniAuth::AuthenticityTokenProtection.new(key: :_csrf_token)
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '252240531889260', '40f2e82b919a27b6a8217023dd1847da'
end

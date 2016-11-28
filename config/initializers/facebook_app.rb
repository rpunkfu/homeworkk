if Rails.env == 'development' || Rails.env == 'test'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '1894774840756659', 'DEV_APP_SECRET'
  end
else
  # Production
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '1798319283735549', '7e1cb8536d22cef46f21f8d2b705cd43'
  end
end
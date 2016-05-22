class MyTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["172d50fb1a951d0a32dee40804fedab6"] = RequestStore.store[:my_api_token]
    @app.call(env)
  end
end
Her::API.setup url: "https://graph.facebook.com/v2.6/me/messages?access_token=EAAZAjj9YZAiZC0BAFZCao4ZADSMy9o60qDLr2y8zvB14OElmfuXyNq6LbjRwwSPAptK9eNGcHI73VLKaTrk5R6nanUa7mFJPD0Rp5p0p0ZBPOanIRkZABOX9ZC590Q5WfNAABPlRwf1GmWRhhtxnMgeOZBcylDMCrpwjXOS1NBaTDwwZDZD" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end
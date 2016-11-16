class ChristopherbotRedirector
  def self.call(env)
    if env["HTTP_HOST"] == "www.christopherbot.co"
      [301, {"Location" => "http://christopherbot.co/"}, ["Found"]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
require 'test_helper'

class HooksControllerTest < ActionController::TestCase
  test "should get receive" do
    get :receive
    assert_response :success
  end

	context "Heroku types, sending params" do

	  before(:each) do
	    request.headers['Content-Type'] = "application/x-www-form-urlencoded"
	  end

	  let(:received_params) do
	    {
	      app: "motionai",
	      user: "nicolas@cookieshq.co.uk",
	      head: "1234",
	      head_long: "12345678",
	      url: "https://applicationName.com",
	      git_log: "  * My push"
	    }
	  end

	  let(subject) { post :receive, {integration_name: "motion_callback"}.merge(received_params) }

	  describe "#receives a deploy hook" do
	    it "calls the Webhook::Received service" do
	      expect(Webhooks::Received).to receive(:save).with(data: {integration_name: "motion_callback"}.merge(received_params), integration: "heroku").and_return(true)

	      subject
	    end
  	  end

	end
end
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
	      reply: "yes"
	    }
	  end

	  let(subject) { post :receive, {integration_name: "motion_callback"}.merge(received_params) }

	  describe "#receives a deploy hook" do
	    it "calls the Webhook::Received service" do
	      expect(Webhooks::Received).to receive(:save).with(data: {integration_name: "motion_callback"}.merge(received_params), integration: "motion_callback").and_return(true)

	      subject
	    end
  	  end

	end
end
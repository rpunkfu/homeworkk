require 'test_helper'

class HooksControllerTest < ActionController::TestCase
  test "should get receive" do
    get :receive
    assert_response :success
  end

  context "Busnag types, JSON received" do

    before(:each) do
      request.headers['Content-Type'] = "application/json"
    end

    let(json_file) { "#{Rails.root}/spec/fixtures/webhooks/bugsnag/exception.json" }
    let(subject) { post :receive, {integration_name: "motion_callback"} }

    # what to write for the following line
    describe "#receive #{event_type}" do

      it "creates a new BugsnagWebhook submission" do
        request.env['RAW_POST_DATA'] = File.read(json_file)
        data = JSON.parse(File.read(json_file))
        expect(Webhooks::Received).to receive(:save).with(data: data, integration: "motion_callback").and_return(true)
        subject
      end
    end
	end

end

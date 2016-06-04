class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
    data = JSON.parse(request.body.read)

    Webhook::Received.save(data: data, integration: params[:motion_callback])

    render nothing: true

    context "Busnag types, JSON received" do

      before(:each) do
        request.headers['Content-Type'] = "application/json"
      end

      let(json_file) { "#{Rails.root}/spec/fixtures/webhooks/bugsnag/exception.json" }
      let(subject) { post :receive, {integration_name: "bugsnag"} }

      describe "#receive #{event_type}" do

        it "creates a new BugsnagWebhook submission" do
          request.env['RAW_POST_DATA'] = File.read(json_file)
          data = JSON.parse(File.read(json_file))
          expect(Webhooks::Received).to receive(:save).with(data: data, integration: "bugsnag").and_return(true)
          subject
        end
      end
    end

end
end
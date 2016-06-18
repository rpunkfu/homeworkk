class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def receive
  	if request.headers['Content-Type'] == 'application/json'
     data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = params.as_json
    end

    Webhook::Received.save(data: data, integration: params[:motion_callback])
    render nothing: true

   context "Busnag types, JSON received" do

	    before(:each) do
	      request.headers['Content-Type'] = "application/json"
	    end

	    let(json_file) { "#{Rails.root}/app/views/hooks/exception.json" }
	    let(subject) { post :receive, {integration_name: "motion_callback"} }

	    describe "#receive #{event_type}" do

	      it "creates a new BugsnagWebhook submission" do
	        request.env['RAW_POST_DATA'] = File.read(json_file)
	        data = JSON.parse(File.read(json_file))
	        expect(Webhooks::Received).to receive(:save).with(data: data, integration: "motion_callback").and_return(true)
	        subject
	        $datastuff = data
	      end
	    end
	end


 end

 def stuff
 	@data = $datastuff
 end

end

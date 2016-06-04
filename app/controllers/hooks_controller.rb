class HooksController

  def motion_created_callback
    # If the body contains the survey_name parameter...
    if params[:from].present?
      # Create a new Survey object based on the received parameters...
      message = Message.new(:from => params[:from]
      message.reply = params[:reply]
      survey.direction = params[:direction]
      survey.save!
    end

    # The webhook doesn't require a response but let's make sure
    # we don't send anything
    render :nothing => true
  end

end
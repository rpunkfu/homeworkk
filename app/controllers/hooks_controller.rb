class HooksController

  def survery_created_callback
    # If the body contains the survey_name parameter...
    if params[:reply].present?
      # Create a new Survey object based on the received parameters...
      $survey = Messagehuman.new(:name => params[:reply]
      $survey.url = params[:replyData]
      $survey.creator_email = params[:from]
      $survey.save!
    end

    # The webhook doesn't require a response but let's make sure
    # we don't send anything
    render :nothing => true
  end

end
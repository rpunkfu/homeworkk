class HooksController < ApplicationController
  before_filter :set_webhook_variable
  before_filter :receive
  skip_before_filter :verify_authenticity_token

  def receive
    puts "hello"
  	if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      # application/x-www-form-urlencoded
      data = request.body.read
    end

=begin
    if data.reply === 'yes' # Note that this is probably not the best way to check which stage in the conversation we're at (depends on the question right?) but I'm not really sure
      @homework = new Homework() # create a new Homework model and add it to the Homeworks table in thedatabase
      @homework.save
    elsif data.reply === 'no'
        # Do something here, but don't create a new homework.
    else # I'm just assuming here that any other response will include Homework details.
      @homework = Homework.where(owner: data.from, date: data.date) # OK syntax might be wrong here. I'm searching in the database's Homeworks table for the Homework that was created earlier, using the `from` string as an identifier for who the owner is.
      @homework.details = data.reply # setting the "details" attribute of the Homework model that we found in the database, to equal the reply content, assuming it was about homework details.
    end
=end
  
    @dataArray.push("data: ", data)
  end
	
  def test
    @test = @dataArray
  end

  private

  def set_webhook_variable
    @dataArray = Array.new
  end
end
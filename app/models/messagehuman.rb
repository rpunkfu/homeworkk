class Messagehuman
  require 'json'
  if Rails.env.staging?
    $page_access_token = "EAAIgtnRF648BABaZCpNurJN2GBzjZC6jQZAZCCdQE90mluLc5jooAfHrFgSxsYT2eTeu9sXVjWWiFc1gZBXn5if7OC2Q4hXsnHwxrSDg7anLuzPnRzUvicPv5R1AXxkjZAS2Xhm7KknwGlx0poBZC7IFNhRyNHnWabn59f7CkwnjAZDZD"
  else
    $page_access_token = "EAAZAjj9YZAiZC0BAOFT4SiXhnIqinWdveXxBf8AvDMAGMXamAIQobjfYRIv9Iw85UcZBXOqla4XpWtUJ6fooeBpM4LtB9hUwOYeRsokcOKUa40gM9RpKgtCTxHiFde52R4i3PZAfMijyw3NZACCYILq3hWeCipeq5gCLuyZASBn6gZDZD"
  end
  # method to send string message to user
	def self.sendMessage(recipient, message)
    # pace access token for facebook
		page_access_token = 'EAAZAjj9YZAiZC0BAOFT4SiXhnIqinWdveXxBf8AvDMAGMXamAIQobjfYRIv9Iw85UcZBXOqla4XpWtUJ6fooeBpM4LtB9hUwOYeRsokcOKUa40gM9RpKgtCTxHiFde52R4i3PZAfMijyw3NZACCYILq3hWeCipeq5gCLuyZASBn6gZDZD'
 		body = {
 			recipient: {
   			id: recipient
 			},
 			message: {
   			text: message
 			},
		}.to_json
		response = HTTParty.post(
 			"https://graph.facebook.com/v2.6/me/messages?access_token=#{$page_access_token}",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end
  
  def self.string_difference_percent(a, b)
    longer = [a.size, b.size].max
    same = a.each_char.zip(b.each_char).select { |a,b| a == b }.size
    return (longer - same) / a.size.to_f
  end

  def self.sendMessageBubbles(recipient)
    page_access_token = 'EAAZAjj9YZAiZC0BAOFT4SiXhnIqinWdveXxBf8AvDMAGMXamAIQobjfYRIv9Iw85UcZBXOqla4XpWtUJ6fooeBpM4LtB9hUwOYeRsokcOKUa40gM9RpKgtCTxHiFde52R4i3PZAfMijyw3NZACCYILq3hWeCipeq5gCLuyZASBn6gZDZD'
    body = {
      recipient: {
        id: recipient
      },
      sender_action: "typing_on"
    }
    response = HTTParty.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=#{$page_access_token}",
      body: body,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

	def self.sendBinaryMessage(recipient, message)
		page_access_token = 'EAAZAjj9YZAiZC0BAOFT4SiXhnIqinWdveXxBf8AvDMAGMXamAIQobjfYRIv9Iw85UcZBXOqla4XpWtUJ6fooeBpM4LtB9hUwOYeRsokcOKUa40gM9RpKgtCTxHiFde52R4i3PZAfMijyw3NZACCYILq3hWeCipeq5gCLuyZASBn6gZDZD'
 		body = {
 			recipient: {
   			id: recipient
 			},
 			message: {
   			text: message,
   			quick_replies: [
      	{
        	content_type: "text",
        	title: "yes", 
        	payload: 'Yes'	
      	},
      	{
        	content_type: "text",
        	title: "no",
        	payload: 'No'
      	}
   			]
 			}
		}.to_json
		response = HTTParty.post(
 			"https://graph.facebook.com/v2.6/me/messages?access_token=#{$page_access_token}",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

	def self.checkKeyWords(recipient, userText)
    $subject = nil
    $keyWords = Array.new
    @user = User.find_by(conversation_id: recipient)
    $userTodayGroups = Array.new
    @user.groups.where("group_day = ?", 0.hours.ago.strftime("%A").downcase).each do |group| $userTodayGroups.push(group.group_name.downcase) end
		$textArray = userText.split(" ")
    $textArray.each do |word|
      if word == "have" || word == "homework" || $userTodayGroups.include?(word)
        if $userTodayGroups.include?(word)
          $subject = word.downcase
        end
        $keyWords.push(word)
      end
    end
    if $subject.nil?
      $possibleSubjects = Array.new
      $textArray.each do |word|
        $userTodayGroups.each do |group|
          if Messagehuman.string_difference_percent(word, group) <= 0.5
            $possibleSubjects.push(group)
          end
        end
      end
    end
    if $keyWords.include?("have") && $keyWords.include?("homework") && !$subject.nil?
      @group = Group.find_by(conversation_id: recipient, group_day: 0.hours.ago.strftime("%A").downcase, group_name: $subject.downcase)
      @group.update(homework_assigned: true)
      @group = @group.as_json
      @group["id"] = nil
      @group.delete("name")
      groupArrayNew = Grouparray.new(@group)
      groupArrayNew.save
      return true
    elsif $keyWords.include?("have") && $keyWords.include?("homework") && !$possibleSubjects.empty?
      return false
    else
      return nil
    end
	end


	def self.checkUserExists(recipient)
		if User.find_by(conversation_id: recipient).nil?
      @messageText = false
 		else
 			@messageText = true
 		end
 		return @messageText
 	end

 	def self.sendButton(recipient)
  page_access_token='EAAZAjj9YZAiZC0BAMJmsPEAp8PEhWvOc1DEDrPQFkzZBZBd9BgCx8ZCzRk7LAQHxSkJZARMS9vGiIihyyenuzsZBqkMAeEW7vT3ukxjRRqHRTbBx5BlNauoXtgwy3lR6zosx70CzgiyiLZArTr1mZCQoqZBrsDOZAerirrbBHL2wumq19wZDZD'
 	body = {
 		"recipient":{
    	id: recipient
  	},
  	message:{
    	attachment:{
     		type:"template",
     		payload: {
       		template_type:"generic",
        	elements:[
         	{
            title:"Sign Up For Christopher Bot",
           	subtitle:"To keep track of your homework",
           	buttons:[
              			{
                type:"web_url",
               	url:"https://www.christopherbot.co/users/sign_in?conversation_id=" + recipient,
                title:"Sign Up",
                webview_height_ratio:"tall"
              }
            	]
          	}
        	]
      	}
   	}
 	 } 
  }.to_json

	response = HTTParty.post(
	 	"https://graph.facebook.com/v2.6/me/messages?access_token=#{$page_access_token}",
	 	body: body,
	 	headers: { 'Content-Type' => 'application/json' }
	)
end

def self.sendSummaryButton(recipient)
  page_access_token='EAAZAjj9YZAiZC0BAMJmsPEAp8PEhWvOc1DEDrPQFkzZBZBd9BgCx8ZCzRk7LAQHxSkJZARMS9vGiIihyyenuzsZBqkMAeEW7vT3ukxjRRqHRTbBx5BlNauoXtgwy3lR6zosx70CzgiyiLZArTr1mZCQoqZBrsDOZAerirrbBHL2wumq19wZDZD'
  body = {
    "recipient":{
      id: recipient
    },
    message:{
      attachment:{
        type:"template",
        payload: {
          template_type:"generic",
          elements:[
          {
            title:"See All Your Homework",
            subtitle:"To see all your homework for the week",
            buttons:[
                    {
                type:"web_url",
                url:"https://www.christopherbot.co/",
                title:"See My Homework",
                webview_height_ratio:"tall"
              }
              ]
            }
          ]
        }
    }
   } 
  }.to_json

  response = HTTParty.post(
    "https://graph.facebook.com/v2.6/me/messages?access_token=#{$page_access_token}",
    body: body,
    headers: { 'Content-Type' => 'application/json' }
  )
end

def self.sendGroupConfirmMessage(recipient, possibleClasses)
    page_access_token = 'EAAZAjj9YZAiZC0BAOFT4SiXhnIqinWdveXxBf8AvDMAGMXamAIQobjfYRIv9Iw85UcZBXOqla4XpWtUJ6fooeBpM4LtB9hUwOYeRsokcOKUa40gM9RpKgtCTxHiFde52R4i3PZAfMijyw3NZACCYILq3hWeCipeq5gCLuyZASBn6gZDZD'
    body = {
      recipient: {
        id: recipient
      },
      message: {
        text: "sorry, which class do you have homework for?",
        quick_replies: [
        {
          content_type: "text",
          title: possibleClasses[0].downcase,
          payload: possibleClasses[0].downcase
        }
      ]
      }
    }.to_json
    response = HTTParty.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=#{$page_access_token}",
      body: body,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
			
end
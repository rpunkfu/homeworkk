class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  include MessengerHelper
  # GET /groups
  # GET /groups.json

  def index
    if user_signed_in? && current_user.class_number.to_i.nil?
      @setUserClassNumber = User.find_by(id: current_user.id)
      @setUserClassNumber.update(class_number: "5")
      @setUserClassNumber.save 
    end
    @groups = Group.all
    @user = current_user
    if user_signed_in? && current_user.conversation_id.nil?
      @user = current_user
      @user.update(conversation_id: $conversation_id)
      @user.save
    end
    page_access_token = 'EAAZAjj9YZAiZC0BAMAQ5ZCebCvomc1uET1dns9KbhNleTZChhsKyo5WAD0fXvdZAj5RbZBEUbADcTactqxkleZB3XmmeEH348xdk4dibeQzMhaDxNQtF51ZA0Vf8ZAqnlCSgzhpl286TwFoPK3gFGpPK4Rdk0rvmp0hh5gmpfPWbOJCwZDZD'

    body = {
     recipient: {
       id: '134381003642835'
     },
     message: {
       text: 'hi alec'
     }
    }.to_json
    
    response = HTTParty.post(
     "https://graph.facebook.com/v2.6/me/messages?access_token=#{page_access_token}",
     body: body,
     headers: { 'Content-Type' => 'application/json' }
    )
    render :nothing => true, status: 200
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @classSignUpDay = "monday" # day your class is for
    @group = current_user.groups.build  # so you can create new classes
    @groups = current_user.groups # list of the user's groups
    @groups.each do |group| # if the group day exists, then set @classSignUpDay to the next
      case group.group_day
        when "monday"
          @yesterdayClassDay = "monday"
          @classSignUpDay = "tuesday"
        when "tuesday"
          @yesterdayClassDay = "tuesday"
          @classSignUpDay = "wednesday"
        when "wednesday"
          @yesterdayClassDay = "wednesday"
          @classSignUpDay = "thursday"
        when "thursday"
          @yesterdayClassDay = "thursday"
          @classSignUpDay = "friday"
        when "friday"
          redirect_to groups_path, notice: "You have already set up all your classes, edit them instead"
          break
        else
      end
    end 
    @yesterday_groups = current_user.groups.where("group_day = ?", @yesterdayClassDay) # groups for set from yesterday
  end

  # GET /groups/1/edit
  def edit
    @groups = current_user.groups.where("group_day = ?", @group.group_day) # edit all the groups from the selected group day
    $groupUpdateNumber = @groups.count # amount of original groups in update page
  end

  # POST /groups
  # POST /groups.json
  def create
    counter = 0
    # for each class created, loop through it and enter it into the database, increment counter as well
    if !params[:group].nil?
      params[:group].each do |group|
        next if group[:name].blank? || group[:end_time].blank?
        @group = current_user.groups.build(name: group[:name], end_time: group[:end_time], group_day: group[:group_day], conversation_id: group[:conversation_id])
        @group.save
        counter += 1
      end
      if @group.save
        redirect_to groups_path, notice: "Class was successfully created"
      else
        render :new
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    counter = 0
    groupCounter = 1
    if !params[:group].nil?
      params[:group].each do |group|
        if groupCounter > $groupUpdateNumber
          break if group[:name].blank? || group[:end_time].blank?
          @group = current_user.groups.build(name: group[:name], end_time: group[:end_time], group_day: group[:group_day], conversation_id: group[:conversation_id])
          @group.save
        end
        next if group[:name].blank? || group[:end_time].blank?
        @group.update(name: params[:group][counter][:name], end_time: params[:group][counter][:end_time], group_day: params[:group][counter][:group_day])
        counter += 1
        groupCounter += 1
      end
    end
    redirect_to groups_path, notice: "Successfully Updated"
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'Class was removed'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.permit(group: [:group, :name, :fb_id, :group_num, :group_day, :end_time, :homework_assigned, :homework_assignment, :conversation_id]).require(:group)
    end
end

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  require 'json'
  include MessengerHelper
  # GET /groups
  # GET /groups.json

  def index
     @timeZones = [["Pacific Time", -8], ["Mountain", -7],["Central Time", -6],["Eastern Time", -5],["Atlantic Time", -4]] 
    if user_signed_in? && current_user.class_number.nil? && !params["user"].nil?
      @setUserClassNumber = User.find_by(id: current_user.id)
      @setUserClassNumber.update(time_zone: params["user"]["time_zone"].to_i, class_number: params["user"]["class_number"].to_i)
      @setUserClassNumber.save
      if !current_user.groups.nil?
        current_user.groups.each do |group|
          group.update(time_zone: current_user.time_zone)
        end
      end
      redirect_to root_path
    end
    @groups = Group.all
    @user = current_user if user_signed_in?
    if user_signed_in? && current_user.conversation_id.nil?
      @user = current_user
      @user.update(conversation_id: $conversation_id)
      @user.save
    end
    if user_signed_in?
     @userGroups = current_user.groups
    @classSignUpDay = "monday"
     @userGroups.each do |group|# if the group day exists, then set @classSignUpDay to the next
      case group.group_day
        when "monday"
          @classSignUpDay = "tuesday"
        when "tuesday"
          @classSignUpDay = "wednesday"
        when "wednesday"
          @classSignUpDay = "thursday"
        when "thursday"
          @classSignUpDay = "friday"
        else
        end
     end
    end
  end

  def checkIfHomework(group)
    if group.homework_assigned == true
      return "yes"
    elsif group.homework_assigned == false
      return "no"
    else 
      return ""
    end
  end
  helper_method :checkIfHomework


  # GET /groups/1
  # GET /groups/1.json
  def show
    redirect_to root_path
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
          redirect_to root_path, notice: "You have already set up all your classes, edit them instead"
          break
        else
      end
    end 
    @yesterday_groups = current_user.groups.where("group_day = ?", @yesterdayClassDay).order("end_time ASC") # groups for set from yesterday
  end

  # GET /groups/1/edit
  def edit
    @groups = current_user.groups.where("group_day = ?", @group.group_day).order("end_time ASC").to_a # edit all the groups from the selected group day
    $groupUpdateNumber = @groups.count # amount of original groups in update page
    $groupsId = Array.new
    current_user.groups.where("group_day = ?", @group.group_day).each do |group|
      group = group.as_json
      $groupsId.push(group["id"])
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    counter = 0
    # for each class created, loop through it and enter it into the database, increment counter as well
    if !params[:group].nil?
      params[:group].each do |group|
        next if group[:group_name].blank? || group[:end_time].blank?
        @group = current_user.groups.build(group_name: group[:group_name], end_time: group[:end_time], group_day: group[:group_day], conversation_id: group[:conversation_id], time_zone: current_user.time_zone)
        @group.save
        counter += 1
      end
      if @group.save
        redirect_to root_path, notice: "classes were successfully created"
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
      $inspectparams = params[:group]
      params[:group].each do |group|
        if groupCounter > $groupUpdateNumber
          break if group[:group_name].nil? || group[:end_time].nil?
          @group = current_user.groups.build(group_name: group[:group_name], end_time: group[:end_time], group_day: group[:group_day], conversation_id: group[:conversation_id, time_zone: current_user.time_zone])
          @group.save
        end
        next if group[:group_name].nil? || group[:end_time].nil?
        @groupUpdate = Group.find_by(id: $groupsId[counter])
        @groupUpdate.update(group_name: group[:group_name], end_time: group[:end_time], time_zone: current_user.time_zone)
        puts "this is @group: " + @group.inspect.to_s
        groupCounter += 1
        counter += 1
      end
    end
    redirect_to root_path, notice: "successfully updated your classes"
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    redirect_to root_path, notice: 'Class was removed'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.permit(group: [:group, :name, :fb_id, :group_num, :group_day, :end_time, :homework_assigned, :homework_assignment, :conversation_id, :time_zone]).require(:group)
    end
end

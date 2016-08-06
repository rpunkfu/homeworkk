class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @sign_up_day = "monday"
    @group = current_user.groups.build
    @groups = current_user.groups
    @groups.each do |group|
      case group.group_day
        when "monday"
          @yesterday = "monday"
          @sign_up_day = "tuesday"
        when "tuesday"
          @yesterday = "tuesday"
          @sign_up_day = "wednesday"
        when "wednesday"
          @yesterday = "wednesday"
          @sign_up_day = "thursday"
        when "thursday"
          @yesterday = "thursday"
          @sign_up_day = "friday"
        when "friday"
          redirect_to groups_path, notice: "You have already set up all your classes, edit them instead"
          break
        else
      end
    end 
    @yesterday_groups = current_user.groups.where("group_day = ?", @yesterday)

  end

  # GET /groups/1/edit
  def edit
    @groups = current_user.groups.where("group_day = ?", @group.group_day)
    $groupUpdateNumber = @groups.count
  end

  # POST /groups
  # POST /groups.json
  def create
    counter = 0
    # for each class created, loop through it and enter it into the database, increment counter as well
    params[:group].each do |group|
      next if group[:name].blank? || group[:end_time].blank?
      @group = current_user.groups.build(name: params[:group][counter][:name], end_time: params[:group][counter][:end_time], group_day: params[:group][counter][:group_day])
      @group.save
      counter += 1
    end
    if @group.save
      redirect_to groups_path, notice: "Class was successfully created"
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    counter = 0
    groupCounter = 1
    params[:group].each do |group|
      if groupCounter > $groupUpdateNumber
        break if group[:name].blank? || group[:end_time].blank?
        @group = current_user.groups.build(name: params[:group][counter][:name], end_time: params[:group][counter][:end_time], group_day: params[:group][counter][:group_day])
        @group.save
      end
      next if group[:name].blank? || group[:end_time].blank?
      @group.update(name: params[:group][counter][:name], end_time: params[:group][counter][:end_time], group_day: params[:group][counter][:group_day])
      counter += 1
      groupCounter += 1
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
      params.permit(group: [:group, :name, :fb_id, :group_num, :group_day, :end_time, :homework_assigned, :homework_assignment]).require(:group)
    end
end

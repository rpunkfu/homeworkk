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
    @group = current_user.groups.build
    @sign_up_day = "monday"
  end

  # GET /groups/1/edit
  def edit
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
    if @group.update(group_params)
      redirect_to groups_path, notice: 'Class was successfully updated'
    else 
      render :edit
    end
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

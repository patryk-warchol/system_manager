class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :start_project, :stop_project]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def start_project
    start = @project.start_cmd

    start.sub! 'project_path', @project.path
    start.sub! 'project_name', @project.name 

    #render plain: start
    system( start )

    redirect_to controller: 'statics', action: 'home'
  end

  def stop_project
    list_of_processes = []

    # list of processes for project_name
    `ps aux | grep #{@project.name} | awk '{print $2}'`.split("\n").each do |process_pid|
      list_of_processes << process_pid
    end

    list_of_processes.each do |process_pid|
      `kill -9 #{process_pid}`
    end

    redirect_to controller: 'statics', action: 'home'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :path, :port, :environment, :term_for_grep, :start_cmd)
    end
end

class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show edit update destroy ]

  # GET /applications
  def index
    @applications = Current.user.applications
  end

  # GET /applications/1
  def show
  end

  # GET /applications/new
  def new
    @application = Current.user.applications.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  def create
    @application = Current.user.applications.new(application_params)

    if @application.save
      redirect_to @application, notice: "Application was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      redirect_to @application, notice: "Application was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy!
    redirect_to applications_path, notice: "Application was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Current.user.applications.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.expect(application: [ :name, :url, :description, :redirect_url ])
    end
end

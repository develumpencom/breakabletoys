class ApplicationsController < ApplicationController
  before_action :require_admin
  before_action :set_application, only: %i[ show edit update destroy ]

  def index
    @applications = Current.user.applications
  end

  def show
  end

  def new
    @application = Current.user.applications.new
  end

  def edit
  end

  def create
    @application = Current.user.applications.new(application_params)

    if @application.save
      redirect_to @application, notice: "Application was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @application.update(application_params)
      redirect_to @application, notice: "Application was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy!
    redirect_to applications_path, notice: "Application was successfully destroyed.", status: :see_other
  end

  private
    def set_application
      @application = Current.user.applications.find(params.expect(:id))
    end

    def application_params
      params.expect(application: [ :name, :url, :description, :redirect_url ])
    end
end

class ToysController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_toy, only: [ :show, :edit, :update, :destroy ]

  def index
    @toys = Toy.all
  end

  def show
  end

  def new
    @toy = Toy.new
  end

  def edit
  end

  def create
    @toy = Toy.new(toy_params)

    if @toy.save
      redirect_to toys_path, notice: "Toy was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @toy.update(toy_params)
      redirect_to toy_path(@toy), notice: "Toy was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @toy.destroy!

    redirect_to toys_path, notice: "Toy was successfully destroyed."
  end

  private

  def toy_params
    params.expect(toy: [ :name, :slug, :url, :short_description, :description, :status ]).tap do |toy|
      toy[:status] = toy[:status].to_i
    end
  end

  def set_toy
    @toy ||= Toy.find(params[:id])
  end
end

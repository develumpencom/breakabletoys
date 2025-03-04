class ToysController < ApplicationController
  allow_unauthenticated_access only: [ :index ]
  before_action :require_admin, only: [ :new, :create ]

  def index
    @toys = Toy.all
  end

  def new
    @toy = Toy.new
  end

  def create
    @toy = Toy.new(toy_params)

    if @toy.save
      redirect_to toys_path, notice: "Toy was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def toy_params
    params.expect(toy: [ :name, :slug, :url, :short_description, :status ]).tap do |toy|
      toy[:status] = toy[:status].to_i
    end
  end
end

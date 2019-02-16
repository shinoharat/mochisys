class ConditionDetailsController < ApplicationController
  before_action :set_condition_detail, only: [:show, :edit, :update, :destroy]

  # GET /condition_details
  def index
    @condition_details = ConditionDetail.all
  end

  # GET /condition_details/1
  def show
  end

  # GET /condition_details/new
  def new
    @condition_detail = ConditionDetail.new
  end

  # GET /condition_details/1/edit
  def edit
  end

  # POST /condition_details
  def create
    @condition_detail = ConditionDetail.new(condition_detail_params)

    if @condition_detail.save
      redirect_to @condition_detail, notice: 'Condition detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /condition_details/1
  def update
    if @condition_detail.update(condition_detail_params)
      redirect_to @condition_detail, notice: 'Condition detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /condition_details/1
  def destroy
    @condition_detail.destroy
    redirect_to condition_details_url, notice: 'Condition detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condition_detail
      @condition_detail = ConditionDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def condition_detail_params
      params.require(:condition_detail).permit(:name, :description, :color_code, :tags)
    end
end

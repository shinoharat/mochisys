class ClothingBrandsController < ApplicationController
  before_action :set_clothing_brand, only: [:show, :edit, :update, :destroy]

  # GET /clothing_brands
  def index
    @clothing_brands = ClothingBrand.all
  end

  # GET /clothing_brands/1
  def show
    respond_to do |format|
      format.html { }
      format.json { render json: @clothing_brand }
    end
  end

  # GET /clothing_brands/new
  def new
    @clothing_brand = ClothingBrand.new
  end

  # GET /clothing_brands/1/edit
  def edit
  end

  # POST /clothing_brands
  def create
    @clothing_brand = ClothingBrand.new(clothing_brand_params)

    if @clothing_brand.save
      redirect_to @clothing_brand, notice: 'Clothing brand was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clothing_brands/1
  def update
    if @clothing_brand.update(clothing_brand_params)
      redirect_to @clothing_brand, notice: 'Clothing brand was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clothing_brands/1
  def destroy
    @clothing_brand.destroy
    redirect_to clothing_brands_url, notice: 'Clothing brand was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clothing_brand
      @clothing_brand = ClothingBrand.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def clothing_brand_params
      params.require(:clothing_brand).permit(:ja_name, :en_name, :description)
    end
end

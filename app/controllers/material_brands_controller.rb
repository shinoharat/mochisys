class MaterialBrandsController < ApplicationController
  before_action :set_material_brand, only: [:show, :edit, :update, :destroy]

  # GET /material_brands
  def index
    @material_brands = MaterialBrand.all
  end

  # GET /material_brands/1
  def show
    respond_to do |format|
      format.html { }
      format.json { render json: @material_brand }
    end
  end

  # GET /material_brands/new
  def new
    @material_brand = MaterialBrand.new
  end

  # GET /material_brands/1/edit
  def edit
  end

  # POST /material_brands
  def create
    @material_brand = MaterialBrand.new(material_brand_params)

    if @material_brand.save
      redirect_to @material_brand, notice: 'Material brand was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /material_brands/1
  def update
    if @material_brand.update(material_brand_params)
      redirect_to @material_brand, notice: 'Material brand was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /material_brands/1
  def destroy
    @material_brand.destroy
    redirect_to material_brands_url, notice: 'Material brand was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_brand
      @material_brand = MaterialBrand.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_brand_params
      params.require(:material_brand).permit(:name, :description)
    end
end

class Admin::ProductCategoriesController < Admin::AdminController
  before_action :set_product_category, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @product_categories = ProductCategory.all
  end

  # GET /products/1 or /products/1.json
  def show  
    @products = @product_category.products
  end

  # GET /products/new
  def new
    @product_category = ProductCategory.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product_category = ProductCategory.new(product_category_params)

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to product_category_url(@product_category), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to product_url(@product_category), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product_category.destroy!

    respond_to do |format|
      format.html { redirect_to product_categories_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_category
      @product_category = ProductCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.require(:product_category).permit(:name, :image, :active)
    end
end

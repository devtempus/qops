class Admin::CategoriesController < Admin::AdminController
  before_action :current_category, only: %i(update edit show update destroy)
  respond_to :html, :js
  def index
  end

  def show
    respond_to :js
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    respond_with({}) do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: 'Category was created.' }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end


  def published
  end

  def destroy
    @category.destroy
    render :index
  end

  private

  def category_params
    params.require(:category).permit(:id, :name, :parent_id)
  end

  def current_category
    @category ||= Category.find(params[:id])
  end
end

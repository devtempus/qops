class Admin::AuthorsController < Admin::AdminController
  before_action :current_author, only: %i(update edit show update destroy)
  respond_to :html, :js

  def index
    @authors ||= Author.paginate(page: params[:page], per_page: Admin::AdminController::PER_PAGE)
  end

  def show
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    respond_with({}) do |format|
      if @author.save
        format.html { redirect_to admin_authors_path, notice: 'Author was created.' }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_with({}) do |format|
      if @author.update(author_params)
        format.html do
          flash[:notice] = 'Author was successfully updated!'
          redirect_to admin_authors_path
        end
      else
        format.html { render :edit }
      end
    end
  end


  def destroy
    @author.destroy
    respond_with({}) do |format|
      format.html do
        flash[:notice] = 'Author was destroyed!'
        redirect_to admin_authors_path
      end
    end
  end

  private


  def author_params
    params.require(:author).permit(:id, :full_name)
  end

  def current_author
    @author ||= Author.find(params[:id])
  end
end

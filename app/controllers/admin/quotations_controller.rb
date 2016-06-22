class Admin::QuotationsController < Admin::AdminController
  before_action :current_quotation, only: %i(update edit show update destroy)
  respond_to :html, :js
  def show
  end

  def index
    @quotations ||= Quotation.paginate(page: params[:page], per_page: Admin::AdminController::PER_PAGE)
  end

  def update
    respond_with({}) do |format|
      if @quotation.update(quotation_params)
        format.html do
          flash[:notice] = 'Quotation was successfully updated!'
          redirect_to admin_quotations_path
        end
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @quotation = Quotation.new
  end

  def create
    @quotation = Quotation.new(quotation_params)
    respond_with({}) do |format|
      if @quotation.save
        format.html { redirect_to admin_quotations_path, notice: 'Quotation was created.' }
      else
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def destroy
    @quotation.destroy
    respond_with({}) do |format|
      format.html do
        flash[:notice] = 'Quotation was destroyed!'
        redirect_to admin_quotations_path
      end
    end
  end

  def publiched
  end

  private

  def quotation_params
    params.require(:quotation).permit(:id, :text, :full_text, :author_id)
  end

  def current_quotation
    @quotation ||= Quotation.find(params[:id])
  end
end

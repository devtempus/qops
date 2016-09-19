class DashboardsController < ApplicationController
  def index
    @quotations ||= Quotation.publicated
                        .paginate page: params[:page],
                                  per_page: ApplicationController::PER_PAGE
  end

  def show
  end
end

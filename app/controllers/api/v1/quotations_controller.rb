module Api
  module V1
    class QuotationsController < Api::BaseController
      respond_to :json
      def index
        respond_with Quotation.publicated
      end

      def create
        return if params[:quotations].empty?
        params[:quotations].each do |quotation_params|
          quotation_author = quotation_params[:author]
          Author.
          Quotation.create quotation_params
        end

        respond_with Quotation.last
      end

      private

      def quotation_params
        params.require(:quotation).permit(:id, :text, :full_text, :author_id)
      end

    end
  end
end

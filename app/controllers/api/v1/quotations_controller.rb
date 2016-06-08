module Api
  module V1
    class QuotationsController < Api::BaseController
      # http_basic_authenticate_with name: 'admin', password: 'qweasdzxc'
      skip_before_action :verify_authenticity_token
      respond_to :json
      def index
        respond_with Quotation.all
      end

      def create
        return if params[:quotations].empty?
        author = JSON.parse params[:author]
        quotations = JSON.parse(params[:quotations])
        Quotation.transaction do
          @author = request_author(JSON.parse(params[:author]))

          @quotations = quotations.each do |quotation_params|
            create_quotation(quotation_params.deep_symbolize_keys, @author)
          end
        end
        respond_with @quotations
      end

      private

      def create_quotation(quotation, author)
        q_option = quotation.deep_symbolize_keys
        Quotation.create author: author, full_text: q_option[:full_text]
      rescue => e
        fail "Create quotation Error! #{e.message}"
      end

      def request_author(author)
        option = author.deep_symbolize_keys
        author = unless Author.find_by_full_name(option[:full_name])
          Author.create full_name: option[:full_name], description: option[:description],
                        die_date: option[:die_date], burn_date: option[:burn_date]
        end
        author
      rescue => e
        fail "Author Error! #{e.message}"
      end

      def quotation_params
        params.require(:quotation).permit(:id, :text, :full_text, :author_id)
      end
    end
  end
end

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
        return if params[:quotation].blank? || params[:author].empty?
        params_author = JSON.parse(params[:author]).deep_symbolize_keys unless params[:author].nil?
        author = request_author(params_author[:full_name])
        quotation = create_quotation(params[:quotation], author)
        categories = request_categories params_author[:categories]
        tags = request_tags(JSON.parse params[:tags])
        data_response =
            {
                author: author,
                quotation: quotation,
                tags: tags.map(&:id),
                categories: categories.map(&:id)
            }
        respond_with data_response, location: root_path
      end

      private

      def create_quotation(quotation_text, author)
        return if quotation_text.blank?
        Quotation.find_or_create_by author_id: author.id, full_text: quotation_text
      rescue => e
        fail "Create quotation Error! #{e.message}"
      end

      def request_author(author_name)
        Author.find_or_create_by full_name: author_name
      rescue => e
        fail "Author Error! #{e.message}"
      end

      def request_tags(tags)
        tags.map{|tag| Tag.find_or_create_by(name: tag)}
      rescue => e
        fail "Tag Error! #{e.message}"
      end

      def request_categories(categories)
        categories = ['none_category'] if categories.empty?
        categories.map{ |category| Category.find_or_create_by name: category }
      rescue => e
        fail "Category Error! #{e.message}"
      end

      def quotation_params
        params.require(:quotation).permit(:id, :text, :full_text, :author_id)
      end
    end
  end
end

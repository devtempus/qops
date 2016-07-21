module Api
  module V1
    class QuotationsController < Api::BaseController
      # http_basic_authenticate_with name: 'admin', password: 'qweasdzxc'
      skip_before_action :verify_authenticity_token
      respond_to :json
      def index
        respond_with Quotation.limit(100)
      end

      def create
        data_params = JSON.parse(params[:data]).deep_symbolize_keys
        return if data_params[:quotation].blank? || data_params[:author].empty?
        params_author = data_params[:author].deep_symbolize_keys unless data_params[:author].nil?
        author = request_author(params_author[:full_name])
        quotation = create_quotation(data_params[:quotation], author)
        request_categories(params_author[:categories], quotation)
        request_tags(data_params[:tags], quotation)

        data_response =
            {
                author: author,
                quotation: quotation,
                tags: quotation.tags.map(&:name),
                categories: quotation.categories.map(&:name)
            }
        respond_with data_response, location: root_path
      end

      def update

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

      def request_tags(tags, quotation)
        tags.map{|tag| quotation.tags << Tag.find_or_create_by(name: tag)}
      rescue => e
        fail "Tag Error! #{e.message}"
      end

      def request_categories(categories, quotation)
        categories = ['none_category'] if categories.empty?
        categories.map{ |category| quotation.categories << Category.find_or_create_by(name: category) }
      rescue => e
        fail "Category Error! #{e.message}"
      end

      def quotation_params
        params.require(:quotation).permit(:id, :text, :full_text, :author_id)
      end
    end
  end
end

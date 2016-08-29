module Api
  module V1
    class BaseController < Api::BaseController
      class_methods
      respond_to :json
    end
  end
end

class Admin::AdminController < ApplicationController
  before_action :all_categories
  layout 'administaration'

  private

  def all_categories
    @categories ||= Category.all
  end
end


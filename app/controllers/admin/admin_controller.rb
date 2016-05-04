class Admin::AdminController < ApplicationController
  before_action :categories
  layout 'administaration'

  private

  def categories
    @categories ||= Category.roots
  end
end


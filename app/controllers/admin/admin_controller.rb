class Admin::AdminController < ApplicationController
  before_action :tree_categories
  layout 'administaration'

  PER_PAGE = 10

  private

  def tree_categories
    @tree_categories = Category.roots.publicated
  end
end


class Admin::AdminController < ApplicationController
  before_action :tree_categories
  layout 'administaration'

  private

  def tree_categories
    @tree_categories = Category.roots.publicated
  end
end


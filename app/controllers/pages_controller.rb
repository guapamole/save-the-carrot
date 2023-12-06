class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    # @cookbook = current_user.cookbook
    # @ingredients
  end
end

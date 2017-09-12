class StaticsController < ApplicationController

  def home
    @technologies = Technology.all.order(:name)
    @projects = Project.all.order(:name)
  end

  def help
  end

end

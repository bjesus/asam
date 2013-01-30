class HomeController < ApplicationController
  def index
  end

  def links
  	@links = App.links
  end

  def help
  end
end

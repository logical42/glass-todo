class PagesController < ApplicationController
  def home
  end
  def pingurl
    render nothing: true
  end
end

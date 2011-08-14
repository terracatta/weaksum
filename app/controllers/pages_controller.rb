class PagesController < ApplicationController
  def home
    @item = Item.new
  end

end

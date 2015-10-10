class TopController < ApplicationController
  def index
    @items = Item.page(1).per(20)
  end
end

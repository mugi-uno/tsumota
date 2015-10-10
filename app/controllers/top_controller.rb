class TopController < ApplicationController
  def index
    @items = Item.all.limit(5)
  end

  
end

class ItemsController < ApplicationController
 
  def show
    @item = Item.find(params[:id])
  end

  def search
    render :json => Item.matched_keyword(params[:keyword])
  end

  def download
    filepath = Rails.root.join('app', 'pdfs', 'hoge.pdf')
  end

end
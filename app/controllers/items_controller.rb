class ItemsController < ApplicationController
 
  def show
    @item = Item.find(params[:id])
  end

  def search
    items = Item.matched_keyword(params[:keyword]).page(1).per(20)
    render partial: 'items/paginate_list', locals: { items: items }
  end

  def download
    # filepath = Rails.root.join('app', 'pdfs', 'hoge.pdf')
  end

end

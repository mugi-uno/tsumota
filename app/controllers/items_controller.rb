class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end

  def search
    items = Item.matched_keyword(params[:keyword]).page(params[:page]).per(20)
    render partial: 'items/paginate_list', locals: { items: items }
  end

  def download
    item = Item.find(params[:id])
    item.download_count += 1
    item.save

    path = Pathname.new(Setting.first.root_path) + item.relative_path
    send_file(path.to_s)
  end

end

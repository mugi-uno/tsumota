class ItemsController < ApplicationController

  # todo : get from settings
  ROOT_PATH = "/Users/mugi/develop/ruby/tsumota/work"
 
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


    logger.info "////// DONWLOAD!!! ::: #{item.download_count}"

    path = Pathname.new(ROOT_PATH) + item.relative_path
    send_file(path.to_s)
  end

end

class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_setting

  def show
  end

  def edit
  end

  def update
    @item.tags.destroy_all
    @item.import_tags_csv item_params[:tags]
    if @item.save
      render :edit
    else
      redirect_to item_path
    end
  end

  def search
    items = Item.matched_keyword(params[:keyword]).page(params[:page]).per(20)
    render partial: 'items/paginate_list', locals: { items: items }
  end

  def download
    item = Item.find(params[:id])
    item.download_count += 1
    item.save

    path = Pathname.new(@setting.root_path) + item.relative_path
    send_file(path.to_s)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_setting
    @setting = Setting.first
  end

  def item_params
    params.require(:item).permit(:tags)
  end
end

class TagsController < ApplicationController
  def show
    @tag = Tag.where(name: params[:name]).first
  end

  def source
    render json: Tag.uniq.order('name ASC').pluck(:name)
  end
end

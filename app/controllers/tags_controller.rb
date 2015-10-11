class TagsController < ApplicationController
  def show
    @tag = Tag.where(name: params[:name]).first
  end
end

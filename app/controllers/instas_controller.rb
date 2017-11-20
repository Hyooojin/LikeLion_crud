class InstasController < ApplicationController
  def index
    @images = Image.all
  end

  def new
  end

  def show
    @image = Image.find(params[:id])
    
  end

  def create
    Image.create(
      image_url: params[:image_url],
      content: params[:content]
      )
      redirect_to '/instas/index'
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    @image.update(
      image_url: params[:image_url],
      content: params[:content]
      )
      redirect_to '/instas/index'
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end
end

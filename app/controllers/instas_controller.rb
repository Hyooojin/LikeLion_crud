class InstasController < ApplicationController
  def index
    @images = Image.all
  end

  def new
  end

  def show
    @image = Image.find(params[:id])
    
    @instauser = Instauser.find(session[:user_id]).images
    
  end

  def create
    Image.create(
      image_url: params[:image_url],
      content: params[:content],
      instauser_id: session[:user_id]
      )
      redirect_to '/instas/index'
  end

  def edit
    @image = Image.find(params[:id])
    
    if session[:user_id] != Image.find(params[:id]).instauser.id
      redirect_to insta_path(@image)
    end
  
  end

  def update
    @image = Image.find(params[:id])
      if session[:user_id] != Image.find(params[:id]).instauser.id
        redirect_to insta_path(@image)
      else
        @image.update(
          image_url: params[:image_url],
          content: params[:content]
          )
          redirect_to '/instas/index'
      end
  end

  def destroy
    @image = Image.find(params[:id])
      if session[:user_id] != Image.find(params[:id]).instauser.id
        redirect_to insta_path(@image)
      else
        @image.destroy
        redirect_to '/instas/index'
      end
  end

end

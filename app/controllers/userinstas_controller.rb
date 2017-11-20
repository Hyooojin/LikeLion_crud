class UserinstasController < ApplicationController
  def index
    @instausers = Instauser.all

  end

  def new
  end

  def create
    Instauser.create(
      email: params[:email],
      name: params[:name],
      password: params[:password]
      )
      
      redirect_to '/instas/index'
  end

  def show
    @instauser = Instauser.find(params[:id])
    
    
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

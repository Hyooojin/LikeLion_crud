class UserinstasController < ApplicationController
  
  # def index
  #   @instausers = Instauser.all

  # end

  
  def sign_up
  end

  
  
  def sign_up_process
    
    Instauser.create(
      email: params[:email],
      name: params[:name],
      password: params[:password]
      )
      
      redirect_to '/instas/index'
  end


  
  
  def login
  end

  
  
  def login_process
    instauser = Instauser.find_by(email: params[:email])
    if instauser
      if instauser.password == params[:password]
        session[:user_id] = instauser.id
        @msg = "로그인 성공"
        # redirect_to '/instas/index'
      else
        @msg = "비밀번호가 일치하지 않습니다."
        # redirect_to '/userinstas/login'
      end
    else 
      @msg = "먼저 회원가입을 해주세요."
      # redirect_to '/userinstas/sign_up'
    end
  end

  
  
  # def show
  #   @instauser = Instauser.find(params[:id])
  # end
  
  
  
  
  # def edit
  # end

  
  
  
  # def update
  # end



  def destroy
    session.clear
    redirect_to '/instas/index'
  end
end

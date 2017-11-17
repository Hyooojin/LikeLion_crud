class QuestionController < ApplicationController
  def index
    @questions = Question.all
  end

  def new

  end

  def create
    # @content = params[:content]
    # @writter = params[:writter]
    # @writter = params[:writter].eql? "private" ? "익명" : params[:writter]
    
    Question.create(
      content: params[:content],
      writter: params[:writter]
      )
      redirect_to '/'
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def sign_up
  end
  
  def sign_up_process
    
    
    Askeduser.create(
      email: params[:email],
      name: params[:name],
      password: params[:password]
      )
    
    redirect_to '/'
  end
  
  def login
  end
  
  def login_process
    # @email = params[:email]
    @name = params[:name]
    @password = params[:password]
    
    @asked = Askeduser.find_by(email: params[:email])
    
    if @asked
      if @asked.password == params[:password]
        session[:id] == @asked.id
        @msg = "로그인 되었습니다."
      redirect_to '/question/login_process'
      else
        @msg = "비밀번호가 잘못되었습니다."
        redirect_to '/question/login_process'
      end
    else
      @masg = "회원가입이 되어있지 않습니다."
      redirect_to '/question/login_process'
    end
  end
  
  def logout
    session.clear
    redirect_to '/'
  end
  
  
  
end

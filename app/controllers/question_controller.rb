class QuestionController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    
    @current_user = Askeduser.find_by_id(session[:id])

  end

  def create
    @current_user = Askeduser.find_by_id(session[:id])

    @writter = params[:writter] #.eql? "private" ? "익명" : params[:writter]
    
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
    @input_email = params[:email]
    @asked = Askeduser.find_by(email: params[:email])
    
    if @asked
      if @asked.password == params[:password]
         @msg = "로그인 되었습니다."
         session[:id] = @asked.id
        # session[:id] = @asked.id
        redirect_to '/'
      else
         @msg = "비밀번호가 잘못되었습니다."
         redirect_to '/question/login'
      end
    else
      @msg = "회원가입이 되어있지 않습니다."
      redirect_to '/question/sign_up'
    end
 
  end
  
  def logout
    session.clear
    redirect_to '/'
  end
  
  
  
end

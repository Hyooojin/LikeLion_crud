# CRUD 뽀개기
# CRUD 1: Like asked homepage
[asked Homepage](http://asked.kr/)<br>
* rails g controller question<br>
    - index, new, create, show, edit, update, destroy<br><br>
* rails g modle question<br>  
    - name, question<br><br>
* rails g modle temp_user<br>
    - email, name, password<br>

## 구현
Step-by-step으로 정리한다. Rails를 활용하여 CRUD를 구현하는 방법을 정리할 것이며,
[멋쟁이 사자처럼](https://likelion.net/)에서 배운 것을 나름대로 단계별로 정리하는 것을 목표로한다.
다양한 실습을 하며 배운 이론과 개념도 다시 재정리 할 수 있으면 좋을 것 같다.
### 1. 환경설정
#### gemfile 설정
1. gemfile에 추가
```
 gem 'rails_db'
 gem 'awesome_print'
 gem 'pry-rails'
```
2. install 
```
$ bundle install
```

### 2. 컨트롤러 생성
#### 1.question_controller 컨트롤러 생성
```
$ rails g controller question index new create show edit update destroy
```
- config > routes.rb 확인
- app > controller > question_controller 확인
- app > view > question 확인

#### 2.routes의 root 설정<br>
root를 설정해야만 바로 url을 눌러서 application을 실행시킬 수 있다. 

### 3. Web Service 구현
#### 1.index page view page 작성
CRUD를 작성하는데에는 순서가 없지만, 개인적으로 프로그래밍 갓입문자로써 index veiw page를 먼저 작성하는 것이 편하다.
```
<a href="/question/new">질문하러 가기</a>
```
#### 2.web 실행
**Run**버튼을 누르고 커멘트창에 url을 Open하면 web이 실행된다.

#### 3.사용자에게 입력받고, 입력받은 값을 보여주도록 한다.

new page에서 사용자에게 질문을 받고, 사용자가 쓴 질문을 다음 단계에서 확인할 수 있도록 한다.
<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>


1. 사용자에게 질문을 받는다.
<p>[index.erb] - 입력 받는 form 만들기</p>
    
    
```
<form action="/question/create">
    <input type="text" name="question" style="height:100px"><br>
    <select name="writter">
      <option value="private">익명</option>
      <option value="public">공개</option>
    </select>
    <input type="submit" value="질문하기">
</form>
```

2. 질문을 다음 페이지에서 볼 수 있도록한다.

<p>[question_controller#create] - 사용자의 입력을 다음 페이지로 넘기기 위한 method작성</p>

```
def create
    @content = params[:content]
    @writter = params[:writter]
 end
```


3. data를 이동시키기 위해서 controller를 작성한다. 

<p> [create.erb] - 값이 잘 넘어오는지 확인</p>
    
```
<h1>질문 내용 보여주기</h1>
<%=@content%>
<%=@writter%>
```

</details>



* HTML에서 ruby 코드를 사용하기 위해서는 <%%>을 사용한다.
* controller에서 정의되는 변수에 @를 붙이면, HTML에서도 변수 안에 담긴 값을 이용할 수 있다.
* 따라서 <%=@content%>는 넘어온 값을 content에 저장시키고 @content를 하면서 Web에서도 변수에 저장된 값을 보여줄 수 있다.





#### 4.DB에 저장
다양한 사용자에게 Web Service를 제공하기 위해서는 많은 사람들을 입력값을 받을 수 있어야 한다. 따라서 여러명의 사용자에게 입력받은 
값을 저장할 수 있는 **Database**가 필요하다. Database를 사용하기 위해서는 MVC패턴 중에 model의 개념을 이용한다. 여러명의 사용자에게 
값을 **입력**받고 그 값을 database에 **저장**하여 필요할 때 database에서 꺼내서 **사용**할 수 있도록 한다.

<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>
1. 값들을 저장할 database를 생성한다.

```
$ rails g modle question content writter
```

- db > maigrate > create_question.rb확인


2. 준비된 테이블을 실제로 생성시킨다.

```
$ rake db:migrate
```

- db > schema.rb를 확인


3. 넘어오는 값들을 database에 **저장**시킨다.
<p> [question_controller#create] - new page에서 얻은 값을 database에 저장하는 처리를 한다.</p>


```
  def create
    @content = params[:content]
    @writter = params[:writter]
  end
```

4. database에 저장시킨 값을 뿌려준다.
<p>[question_controller#index]  - table에 저장된 값을 불러오는 처리를 해주고 @를 사용해 값을 view로 넘긴다.</p>

```
  def index
    @questions = Question.all
  end
```

<p>[index.erb] - 컨트롤러의 index method에서 넘어온 값을 for문을 사용하여 출력시킨다. </p>


```
<h1>Asked-Homepage</h1>
<a href="/question/new">질문하러 가기</a>
<% @questions.each do |question| %>
    <p><%=question.writter%>님의 질문입니다.</p>
    <p><%=question.content%></p>
    <hr>
<% end %>

```
</details>


* 여러 사용자에게 받은 값을 두고두고 보여주기 위해서는 DB에 저장해야 한다.
* DB에 저장하기 위해서 model을 사용한다.
* Model을 이용하면 database에 값을 저장하고, 불러오기가 가능하다.
    * 넘어오는 값들을 database에 저장한다
    * database에 저장된 값을 불러온다.
    * database에 저장된 값들을 이용한다.
* question model을 생성
* 기본url/rails/db 를 하면 web에서 값을 받아 db에 저장된 값들을 쉽게 확인할 수 있다.

#### 5.User의 회원가입과 공개일 경우
질문은 익명/공개로 나뉘는데 회원가입을 통해 질문을 남긴 사용자들은 
자신의 이름을 사용하여 질문을 올릴수도 있고 익명의 이름으로 올릴 수도 있다. 
우선 **회원가입**이라는 절차를 만들어 사용자들에게 이름을 받는다.

<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>
1. user를 저장할 user table 생성

```
$ rails g model askeduser email name password 
```

위의 모델 생성과 같은 절차를 반복한다.

2. routes.rb에 회원가입과 로그인에 쓰일 것들을 라우팅, method정의, view를 만들어준다.
<p>라우팅 => 컨트롤러 method 정의 => veiw 작성의 순서대로 이루어진다. </p>

[routes.rb]에 추가

```
  get 'question/sign_up'
  
  get 'question/sign_up_process'
```

[question_controller]

```  
def sign_up
end
  
def sign_up_process
end

```

[veiws] 파일 생성

`sign_up.erb`와 `sign_up_process.erb`

3. 회원가입을 통해 user값을 입력받고, db에 저장시킨다. 
<p>[sign_up.erb] - user 회원가입 form을 생성</p>

```
<h1>회원가입</h1>
<form action="/question/sign_up_process">
    email: <input type="email" name="email">
    name: <input type="text" name="name">
    password: <input type="password" name="password"><br>
    <input type="submit" value="회원가입">
    
</form>
```

<p>[question_controller#sign_up_process] - 회원가입을 위해 받은 값들을 DB에 저장</p>

```
  def sign_up_process
    
    Askeduser.create(
      email: params[:email],
      name: params[:name],
      password: params[:password]
      )
    
    redirect_to '/'
  end
```


</details>

#### 6.로그인
**로그인**을 하면 질문을 쓸 수 있고, 익명을 선택한 사람은 이름을 보여주지 말고, 
공개를 선택한 사람의 이름만 공개한다. email을 나타내기로 한다.

<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>
1. 앞에와 같은 절차를 반복
<p>라우팅, method정의, view파일 만들기</p>

```
  get 'question/login_process'

  get 'question/logout'
```

2. login 상태를 <strong>유지</strong>하기위해서는 session에 값을 저장한다.

[question_controller#login, #login_process]
```

  def login
  end
  
  def login_process
    
    @asked = Askeduser.find_by(email: params[:email])
    
    if @asked
      if @asked.password == params[:password]
         @msg = "로그인 되었습니다."
         session[:id] = @asked.id
      else
         @msg = "비밀번호가 잘못되었습니다."
      end
    else
      @msg = "회원가입이 되어있지 않습니다."
    end
 
  end
  
```


3. session에 저장한 값으로 로그인된 회원의 정보만 추출가능

[view]에서 로그인의 진행상황을 @msg에 담아 출력해본다.

```
<%=@msg%>
```
redirect_to를 이용해서 다른 곳으로 넘길경우 create.erb에 적용된 
@msg를 볼 수 없지만 나중에 **flash**를 이용하면 메세지를 띄울 수 있다.

</details>
* 입력받은 email로 database에 저장되어 있는 email에 접근한다.
* 선택된 행을 중심으로 상태에 따라 로그인/로그인이 되지 않도록 한다.
* 선택된 행에 password와 입력받은 password가 동일하다면
* session에 id를 저장시켜 추후에 사용된다. 
* 그 외의 비밀번호가 틀렸거나, 회원가입이 안된것은 else문으로 처리해준다.



#### 7.로그아웃
session에 저장된 id를 로그아웃에 사용한다.

<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>
1. logout 라우팅, method, view파일 작성

2. session값에 저장된 id를 지워버린다.


[question_controller#logout]

```
session.clear
redirect_to '/'
```

</details>



#### 8.session
로그인을 한 순간, session에는 user의 id가 저장되게 된다.
로그인 한 경우에만, 질문을 하고, 질문 수정 등 action을 가능하게 하려면?<br>
[How Rails Sessions Work](https://www.justinweiss.com/articles/how-rails-sessions-work/)
<br>
<p><strong>`session` is the perfect place to put this kind of data. Little bis of data you want to keep around for more tha one request.</strong></p>

```
session[:current_user_id] = @user.id

```
<p><strong>A session is jst a place to store data during one request that you can 
read during later requests.</strong></p>

session활용 예
```
def create
  # 
  session[:current_user_id] = @user.id
  # 
end

```

```
def index
  current_user = User.find_by_id(session[:current_user_id])
end
```

<strong>Set a session value</strong>

```
session[:current_user_id] = user.id
```

<strong>Access a session value</strong>

```
some_other_variable_value = session[:other_variable_key]
```
[출저](https://www.theodinproject.com/courses/ruby-on-rails/lessons/sessions-cookies-and-authentication)


<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>
1. 비밀번호가 일치했을 때 id값을 session[:id]에 저장

app/controllers/question_controller.rb#login_process

```
session[:id] = @asked.id
```
email로 해당 Row를 찾고, 비밀번호가 일치했을 때, session[:id]에 그id값을 저장했다.

2. login 후에 session에 저장된 값으로 user 정보를 출력한다. 
<p>session에 저장된 값을 사용할 수 있다.</p>

```
@current_user = Askeduser.find_by_id(session[:id])
```
Askeduser 테이블에서 id로 찾은 session[:id]값을 `currnet_id`에 저장하고 추후 사용

[app/views/new.erb] - select 선택부분의 value를 바꾸어 준다.
```
<select name="writter">
  <option name="private" value="익명" >익명</option>
  <option name="public" value= "<%=@current_user.email %>" >공개</option>
</select>
```

</details>


#### 9.question & private or public & login
<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>

[question_controller]

```
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

```

[routes.rb]
```
Rails.application.routes.draw do
  
  root 'question#index'
  
  get 'question/index'

  get 'question/new'

  get 'question/create'

  get 'question/show'

  get 'question/edit'

  get 'question/update'

  get 'question/destroy'
  
  get 'question/sign_up'
  
  get 'question/sign_up_process'
  
  get 'question/login'
  
  get 'question/login_process'

  get 'question/logout'
  
  end

```

[scema.rb]

```
ActiveRecord::Schema.define(version: 20171117164027) do

  create_table "askedusers", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "content"
    t.string   "writter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

```

[index.erb]

```
<h1>Asked-Homepage</h1>
<a href="/qustion/index">home</a>
<% if session[:id]%>
    <a href="/question/logout">로그아웃</a></a><br>
<% else %>
    <a href="/question/sign_up">회원가입</a>
    <a href="/question/login">로그인</a></a>
<% end %>

<a href="/question/new">질문하러 가기</a>

<% @questions.each do |question| %>
    <p><%=question.writter%>님의 질문입니다.</p>
    <p><%=question.content%></p>
    <hr>
<% end %>

```

[new.erb]

```
<h1>질문을 남겨주세요</h1>
<form action="/question/create/<%session[:email]%>">
    <input type="text" name="content" style="height:100px"><br>
    <select name="writter">
      <option name="private" value="익명" >익명</option>
      <option name="public" value= "<%=@current_user.email %>" >공개</option>
    </select>
    <input type="submit" value="질문하기">
</form>
```

[sign_up.erb]

```
<h1>회원가입</h1>
<form action="/question/sign_up_process">
    email: <input type="email" name="email">
    name: <input type="text" name="name">
    password: <input type="password" name="password"><br>
    <input type="submit" value="회원가입">
    
</form>

```

[login.erb]

```
<h1>로그인</h1>
<form action="/question/login_process">
    email: <input type="email" name="email">
    password: <input type="password" name="password"><br>
    <input type="submit" value="로그인">
    
</form>

```

</details>
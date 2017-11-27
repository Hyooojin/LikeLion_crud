# CRUD 뽀개기

# CRUD 1: Like asked homepage

## asked Homepage<br>

- rails g controller question<br>
  - index, new, create, show, edit, update, destroy<br><br>
- rails g modle question<br>  
  - name, question<br><br>
- rails g modle temp_user<br>
  - email, name, password<br>

# 구현

* Step-by-step으로 정리한다. 
* Rails를 활용하여 CRUD를 구현하는 방법을 정리할 것이며, 멋쟁이 사자처럼에서 배운 것을 나름대로 단계별로 정리하는 것을 목표로한다.
* 다양한 실습을 하며 배운 이론과 개념도 다시 재정리 할 수 있으면 좋을 것 같다.

## 1. 환경설정
* gemfile 설정, controller생성, model생성 
* gemfile 설정

1. gemfile에 추가

```ruby
gem 'rails_db'
gem 'awesome_print'
gem 'pry-rails'
```
2. install 

```ruby
$ bundle install
```

* 컨트롤러 생성
  1.question_controller 컨트롤러 생성

```ruby
$ rails g controller question index new create show edit update destroy
```

- config > routes.rb 확인
- app > controller > question_controller 확인
- app > view > question 확인

## 2.routes의 root 설정<br>

root를 설정해야만 바로 url을 눌러서 application을 실행시킬 수 있다. 

## 3. Web Service 구현

#### 1.index page view page 작성 

CRUD를 작성하는데에는 순서가 없지만, 개인적으로 프로그래밍 갓입문자로써 index veiw page를 먼저 작성하는 것이 편하다.

```html
<a href="/question/new">질문하러 가기</a>
```
#### 2.web 실행

Run버튼을 누르고 커멘트창에 url을 Open하면 web이 실행된다.

#### 3.사용자에게 입력받고, 입력받은 값을 보여주도록 한다.

new page에서 사용자에게 질문을 받고, 사용자가 쓴 질문을 다음 단계에서 확인할 수 있도록 한다.
> *  사용자에게 질문을 받는다.
> *  form action을 활용하여 다음페이지로도 사용자에게 받은 입력값을 넘길 수 있도록 한다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. 사용자에게 질문을 받는다.

   * [index.erb] - 입력 받는 form 만들기

```html
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

* [question_controller#create] - 사용자의 입력을 다음 페이지로 넘기기 위한 method작성

```ruby
def create
    @content = params[:content]
    @writter = params[:writter]
 end
```

3. data를 이동시키기 위해서 controller를 작성한다. 

* [create.erb] - 값이 잘 넘어오는지 확인 

```html
    <h1>질문 내용 보여주기</h1>
    <%=@content%>
    <%=@writter%>
```

</details>
<br>
- HTML에서 ruby 코드를 사용하기 위해서는 <%%>을 사용한다.
- controller에서 정의되는 변수에 @를 붙이면, HTML에서도 변수 안에 담긴 값을 이용할 수 있다.
- 따라서 %=@content%는 넘어온 값을 content에 저장시키고 @content를 하면서 Web에서도 변수에 저장된 값을 보여줄 수 있다.


#### 4.DB에 저장 


> * 다양한 사용자에게 Web Service를 제공하기 위해서는 많은 사람들을 입력값을 받을 수 있어야 한다. 따라서 여러명의 사용자에게 입력받은 값을 저장할 수 있는 Database가 필요하다. 
> * Database를 사용하기 위해서는 MVC패턴 중에 model의 개념을 이용한다. 여러명의 사용자에게 값을 입력받고 그 값을 database에 저장하여 필요할 때 database에서 꺼내서 사용할 수 있도록 한다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. 값들을 저장할 database를 생성한다.
-----------

```ruby
$ rails g modle question content writter
```

- db > maigrate > create_question.rb확인

2. 준비된 테이블을 실제로 생성시킨다.
---------------

```ruby
$ rake db:migrate
```

- db > schema.rb를 확인

3. 넘어오는 값들을 database에 저장시킨다.
-------

* [question_controller#create] - new page에서 얻은 값을 database에 저장하는 처리를 한다.

```ruby
def create
 @content = params[:content]
 @writter = params[:writter]
end
```

4. database에 저장시킨 값을 뿌려준다.
-----------

* [question_controller#index]  - table에 저장된 값을 불러오는 처리를 해주고 @를 사용해 값을 view로 넘긴다.

```ruby
def index
 @questions = Question.all
end
```

* [index.erb] - 컨트롤러의 index method에서 넘어온 값을 for문을 사용하여 출력시킨다.

```ruby
<h1>Asked-Homepage</h1>
<a href="/question/new">질문하러 가기</a>
	<% @questions.each do |question| %>
	<p><%=question.writter%>님의 질문입니다.</p>
	<p><%=question.content%></p>
	<hr>
<% end %>
```

</details>

- 여러 사용자에게 받은 값을 두고두고 보여주기 위해서는 DB에 저장해야 한다.
- DB에 저장하기 위해서 model을 사용한다.
- Model을 이용하면 database에 값을 저장하고, 불러오기가 가능하다.
  - 넘어오는 값들을 database에 저장한다
  - database에 저장된 값을 불러온다.
  - database에 저장된 값들을 이용한다.
- question model을 생성
- 기본url/rails/db 를 하면 web에서 값을 받아 db에 저장된 값들을 쉽게 확인할 수 있다.

#### 5.User의 회원가입과 공개일 경우

> * 질문은 익명/공개로 나뉘는데 회원가입을 통해 질문을 남긴 사용자들은 자신의 이름을 사용하여 질문을 올릴수도 있고 익명의 이름으로 올릴 수도 있다. 
> * 우선 회원가입이라는 절차를 만들어 사용자들에게 이름을 받는다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. user를 저장할 user table 생성
--------------------

```ruby
$ rails g model askeduser email name password 
```

위의 모델 생성과 같은 절차를 반복한다.

2. routes.rb에 회원가입과 로그인에 쓰일 것들을 라우팅, method정의, view를 만들어준다.
----------------------

* 라우팅 => 컨트롤러 method 정의 => veiw 작성의 순서대로 이루어진다.
* [routes.rb]에 추가

```ruby
get 'question/sign_up'

get 'question/sign_up_process'
```

* [question_controller]

```ruby
def sign_up
end

def sign_up_process
end
```

3. 회원가입을 통해 user값을 입력받고, db에 저장시킨다. 
------------------------
* [veiws] 파일 생성 - sign_up.erb와 sign_up_process.erb
* [sign_up.erb] - user 회원가입 form을 생성

```ruby
 <h1>회원가입</h1>
 <form action="/question/sign_up_process">
 	email: <input type="email" name="email">
 	name: <input type="text" name="name">
 	password: <input type="password" name="password"><br>
 	<input type="submit" value="회원가입">
 </form>
```
* [question_controller#sign_up_process]
* - 회원가입을 위해 받은 값들을 DB에 저장

```ruby
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
* 회원가입이라는 절차를 통해 값을 입력받는다. 

#### 6.로그인

>* 로그인을 하면 질문을 쓸 수 있고, 익명을 선택한 사람은 이름을 보여주지 말고, 공개를 선택한 사람의 이름만 공개한다. 
>* email을 나타내기로 한다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. 앞에와 같은 절차를 반복
---------------------
* 라우팅, method정의, view파일 만들기

```ruby
get 'question/login_process'

get 'question/logout'
```

2. login 상태를 <strong>유지</strong>하기위해서는 session에 값을 저장한다.
------------------------
* [question_controller#login, #login_process]

```ruby
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
--------------------
* [view]에서 로그인의 진행상황을 @msg에 담아 출력해본다.

```ruby
<%=@msg%>
```

redirect_to를 이용해서 다른 곳으로 넘길경우 create.erb에 적용된 @msg를 볼 수 없지만 나중에 flash를 이용하면 메세지를 띄울 수 있다.

</details>

- 입력받은 email로 database에 저장되어 있는 email에 접근한다.
- 선택된 행을 중심으로 상태에 따라 로그인/로그인이 되지 않도록 한다.
- 선택된 행에 password와 입력받은 password가 동일하다면
- session에 id를 저장시켜 추후에 사용된다. 
- 그 외의 비밀번호가 틀렸거나, 회원가입이 안된것은 else문으로 처리해준다.

#### 7.로그아웃 


> * session에 저장된 id를 로그아웃에 사용한다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. logout 라우팅, method, view파일 작성
----------------------------
2. session값에 저장된 id를 지워버린다.
-----------------------------
* [question_controller#logout]

```ruby
session.clear
redirect_to '/'
```

</details>



#### 8.session


> * 로그인을 한 순간, session에는 user의 id가 저장되게 된다.
> * 로그인 한 경우에만, 질문을 하고, 질문 수정 등 action을 가능하게 하려면?<br>

<strong>How Rails Sessions Work</strong>
<br>
<p><strong>* session is the perfect place to put this kind of data. Little bis of data you want to keep around for more tha one request.</strong></p>

```ruby
session[:current_user_id] = @user.id
```    

<p><strong>* A session is jst a place to store data during one request that you can read during later requests.</strong></p>
Session 활용 예

```ruby
def create
	session[:current_user_id] = @user.id
end

def index
	current_user = 								User.find_by_id(session[:current_user_id])
end
```
<strong>* Set a session value</strong>

```ruby
session[:current_user_id] = user.id
```

<strong>* Access a session value</strong>

```ruby
some_other_variable_value = session[:other_variable_key]
```

출처: [Justin Weiss - How Rails Sessions Work](https://www.justinweiss.com/articles/how-rails-sessions-work/)

<details>
<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>
</summary>

1. 비밀번호가 일치했을 때 id값을 session[:id]에 저장
------------------------
* app/controllers/question_controller.rb#login_process

```ruby
session[:id] = @asked.id
```

email로 해당 Row를 찾고, 비밀번호가 일치했을 때, session[:id]에 그id값을 저장했다.

2. login 후에 session에 저장된 값으로 user 정보를 출력한다. 
---------------------------
* session에 저장된 값을 사용할 수 있다.

```ruby
@current_user = Askeduser.find_by_id(session[:id])
```

Askeduser 테이블에서 id로 찾은 session[:id]값을 currnet_id에 저장하고 추후 사용
</details>

#### 9.question & private or public & login 

> * 공개로 선택했을 때, 익명으로 선택했을 때 글을 올릴 수 있도록 한다. 
<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>
1. 익명과 공개 값을 입력 받을 수 있도록 한다. 
--------------
* [app/views/new.erb] - select 선택부분의 value를 바꾸어 준다.

```ruby
<select name="writter">
	<option name="private" value="익명" >익명</option>
	<option name="public" value= "<%=@current_user.email %>" >공개</option>
</select>
```

2. 익명과 공개값도 controller에서 처리해준다.
------------------
* [question_controller]

```ruby
def new
@current_user = Askeduser.find_by_id(session[:id])
end

def create
	@current_user = Askeduser.find_by_id(session[:id])
	@writter = params[:writter] 
	Question.create(
		content: params[:content],
		writter: params[:writter]
	)
redirect_to '/'
end

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

## 마치며
* [routes.rb]

```ruby
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

* [scema.rb]

```ruby
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

```ruby
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



* [new.erb]

```html

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

* [sign_up.erb]

```html
<h1>회원가입</h1>
<form action="/question/sign_up_process">
	email: <input type="email" name="email">
	name: <input type="text" name="name">
	password: <input type="password" name="password"><br>
<input type="submit" value="회원가입">

</form>
```

* [login.erb]

```ruby
<h1>로그인</h1>
<form action="/question/login_process">
	email: <input type="email" name="email">
	password: <input type="password" name="password"><br>
	<input type="submit" value="로그인">
</form>
```

</details>

# CRUD 2: Like Insta homepage

## Insta Homepage<hr>

- rails g controller insta<br>
  - index, new, create, show, edit, update, destroy<br><br>
- rails g modle images<br>  
  - image_url, content<br><br>
- rails g model insta_user<br>
  - email, name, password<br>

## 구현

* Step-by-step으로 정리한다. Rails를 활용하여 CRUD를 구현하는 방법을 정리할 것이며, 멋쟁이 사자처럼에서 배운 것을 나름대로 단계별로 정리하는 것을 목표로한다.
* 다양한 실습을 하며 배운 이론과 개념도 다시 재정리 할 수 있으면 좋을 것 같다.<br>

## 1. 환경설정


#### gemfile 설정

1. gemfile에 추가
-------------

```ruby
 gem 'rails_db'
 gem 'awesome_print'
 gem 'pry-rails'
```
2. install 
----------

```ruby
    $ bundle install
```
<br>

## 2. 컨트롤러 생성
> * RESTFul CRUD
> * controller 명은 복수인다. 
> * 규칙을 따른다.

1.question_controller 컨트롤러 생성
------------------

```ruby
$ rails g controller instas index new create show edit update destroy
```

<strong>RESTful CRUD</strong><br>
---------------------

단순히 crud에 지나지 않지만, 규칙이 있는 crud라고 생각하면된다. <br>

== (정해진 규칙을 따라 만드는) CRUD<br>

== (의미가 더 명확하게 만드는) CRUD<br> 

== (HTTP Verb를 활용항 만드는 )CRUD<br>

- Http통신을 통해서 무엇을 하는지 명확하게 한다 
  출처: 멋쟁이 사자처럼 수업

- config > routes.rb 확인
- app > controller > instas_controller 확인
- app > view > instas 확인

<p><strong>REST API 가이드</strong></p>
* URL 정보를 표현한다.
* 자원에 대한 행위는 HTTP Method(GET, POST, PUT, DELETE)로 표현한다.
* 여러규칙들 (Convention)
   Routing은 RESTful하게
   *  Resource(조작할 자료) 
     =>controller 이름을 복수형으로
     =>/posts/index
     =>rails g controller posts
   *  단 model은 단수형
     => 복수로 자동으로 만들어지기 때문에
     => 테이블은 자동으로 복수형
     => Post.all

2. routes의 root 설정<br>
-----------------------

root를 설정해야만 바로 url을 눌러서 application을 실행시킬 수 있다. 

```ruby
root 'question#index' 
get 'instas/index'
resources :instas 
```

* resorces :컨트롤명 으로 라우트 설정이 가능하다.

### 3. Web Service 구현

#### 1.index page view page 작성

> * CRUD를 작성하는데에는 순서가 없지만, 개인적으로 프로그래밍 갓입문자로써 index veiw page를 먼저 작성하는 것이 편하다.
> * 첫 question/index에서 insta-home page에 갈 수 있도록 링크를 만든다.

```ruby
<%=link_to 'Insta-Homepage', "/instas/index"%>
```

<strong>Insta-Homepage</strong>

* [views/instas/index]

```ruby
<h1>Insta-Homepage</h1>
<%=link_to '사진 올리기', new_insta_path%>
<a href="/qustion/index">home</a>
<% if session[:id]%>
	<a href="/question/logout">로그아웃</a></a><br>
<% else %>
	<a href="/question/sign_up">회원가입</a>
	<a href="/question/login">로그인</a></a>
<% end %>
```

- link_to 이용하기
- $ rake routes의 path이용
- form_tag이용

#### 2.'form_tag'와 'link_to'


> * form_tag와 link_to 그리고 method, path등을 이용해서 더욱 쉽게 Web Service를 구현한다.

```ruby
$ rake routes
```

- index new create show edit update destroy 
- 명령어를 사용하면 각각의 path와 method를 확인할 수 있다.

#### 3. Insta처럼 사진을 올릴 수 있다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. page 이동
-------------

* [app/views/instas/index] : 이미지 업로드 링크를 만들고, Upload 한 이미지를 출력한다.

```html
<h1>Insta-Homepage</h1>
<%=link_to 'Home', "/instas/index"%>
<br>
<%=link_to '사진 올리기', new_insta_path%>
```
2. 사용자에게 입력을 받는다.
--------------------
* [app/views/instas/new] : image_url과 content를 입력받는다. 

```html
<h1>사진 올리기</h1>
<%=link_to 'Home', "/instas/index"%>
<br>
<%= form_tag instas_path, method:"post" do %>
	사진 주소: <%= text_field_tag :image_url %><br>
	내용: <%= text_field_tag :content %>
	<%=submit_tag("사진 올리기")%>
<% end %>
```

<%= form_tag instas_path, method:"post" do%>를 살펴보면 `instas_path'는 form_action = "/instas/new"와 같다. <br>

insta_path 처럼 path를 덧붙인다. 그리고 정의된 대로 method는 put으로 한다.

```ruby
$ rake routes #에서 확인 가능
```
</details>

#### 4. 인스타에 올린 사진을 수정, 저장을 하기 위해서는 DB가 필요하다.

> * 저장을 하기위해서는 Database가 필요하다.
> * 입력받은 값을 Database에 저장해두어 쓸 수 있도록 한다.
<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. 사용자 입력값을 DB에 저장
---------------------

* [db/migrate/create_images.rb] : images table 정의, 컬럼생성

```ruby
$ rails g model image image_url content
```
<br>

* [db/schema.rb] : images table 생성, 추가

```ruby
$ rake db:migrate
```
<br>

* [app/controller/instas_controller#create]: image라는 model을 생성하고, image_url과 content 컬럼을 생성한다.

```ruby
def create
	Image.create(
		image_url: params[:image_url],
		content: params[:content]
	)
	redirect_to '/instas/index'
end
```

<br>

2. DB에 저장된 값을 출력
-------------------

* [app/controller/instas_controller#index]: Image 테이블에서 값을 불러온다. 

```ruby
def index
	@images = Image.all
end
```
<br>

* [app/views/instas/index.erb]: @images 변수를 사용해 web에서 사용자에게 값을 보여준다.

```ruby
<h1>Insta-Homepage</h1>
<%=link_to 'Home', "/instas/index"%>
<br>
<%=link_to '사진 올리기', new_insta_path%>


<% @images.each do |image|%>
	<p><%=image.image_url%></p>
	<p><%=image.content%></p>
	<%=link_to '[상세보기]', insta_path(image.id) %>
<hr>
<% end %>
```
</details>

#### 5. DB를 사용하여 수정을 할 수 있다.

> * 수정, 저장을 하기위해서는 find함수를 이용한다.
> * 수정할 특정한 이미지를 불러온다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

> * 수정을 하기 위해서는 각각의 게시물에 대한 정보를 받을 수 있어야 한다. find함수를 사용한다. 

1. 상세보기 메뉴에서 수정과 삭제를 할 수 있도록 한다.
----------------

* [app/views/instas/show.erb]

```html
<%=@image.image_url%>
<%=@image.content%>
<%=link_to '[수정]', edit_insta_path(@image.id) %>
<%=link_to '[삭제]', insta_path(@image.id), method:"delete"%>
```

<br>

* [app/controller/instas_controller#show]: 해당 게시물만 받아오고, 보여질 수 있도록 한다.


```ruby
def show
	@image = Image.find(params[:id])
end
```
<br>

2. 수정을 하기 위해서 url에 게시물의 해당id값을 함께 넘겨준다.
-------------------

* [app/views/instas/edit.erb]

```html
<h1>수정</h1>
<%=link_to 'Home', "/instas/index"%>
<br>

<%= form_tag insta_path(@image.id), method:"put" do %>
	사진 주소: <%= text_field_tag :image_url, @image.image_url %><br>
	내용: <%= text_field_tag :content, @image.content %>
	<%=submit_tag("사진 올리기")%>
<% end %>
<br>
```


* [app/controller/instas_controller#edit, #update]

```ruby
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
```

</details>

- 수정을 하기 위해서는 해당 게시물만 선택하기 위해서 URL에 id값을 함께 넘겨준다.edit_insta_path(@image.id)
- 해당 게시물을 찾기 위해 row를 선택, Image.find(params[:id])를 사용해 row를 선택한다.
- 선택된 row를 @image 변수에 저장하고, @image 변수를 사용해 web에서도 출력할 수 있도록 한다.

#### 6. Image가 뜰 수 있도록 변경한다.

> * Image를 뜨기 하기 위해서는 새로운 tag를 사용한다.
<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. image가 뜨려면, image_tag로 바꾸어준다.
----------------

* [app/views/instas/#index.erb, #show.erb]

```html
<--!index.erb-->
<% @images.each do |image|%>
	<p><%=image_tag image.image_url%></p>
	<p><%=image.content%></p>
	<%=link_to '[상세보기]', insta_path(image.id) %>
	<hr>
<% end %>

<--!show.erb-->
<%=image_tag @image.image_url%><br>
<%=@image.content%>
<%=link_to '[수정]', edit_insta_path(@image.id) %>
<%=link_to '[삭제]', insta_path(@image.id), method:"delete"%>

<--!edit.erb-->
<h1>수정</h1>
<%=link_to 'Home', "/instas/index"%>
<br>
<%= form_tag insta_path(@image.id), method:"put" do %>
<%= image_tag @image.image_url%><br>
사진 주소 변경: <%= text_field_tag :image_url, @image.image_url %><br>
내용 변경 : <%= text_field_tag :content, @image.content %><br>
<%=submit_tag("사진 올리기")%>
<% end %>
```

* Image_url을 진짜 Image가 뜨도록 할 수 있다.
</details>

#### 7. User

> * 회원가입, Login
<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

- 회원가입, 로그인, 로그아웃
- controller : #userinstas
  - index new create show edit update destroy sign_up sign_up_process login login_process
- model : instauser
  - email, name, password

1. 회원가입
------------
* [app/views/userinstas/sign_up.erb]

```html
#app/views/userinstas/sign_up.erb
<h1>로그인</h1>
<%=form_tag '/userinstas/login_process', method:"post" do%>
	email: <%=text_field_tag :email%><br>
	name: <%=text_field_tag :name%><br>
    password: <%=text_field_tag :password%><br>
    <%=submit_tag('로그인')%>
<% end %>
```

* [app/controllers/userinstas_controller.rb]
```ruby
#app/controllers/userinstas_controller.rb
# sign_up, sign_up_process

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
```
2. 로그인
-------------------------
   - find(params[:id])
   - find_by(email: params[:email])
   - DB에 저장된 password == params[:password]
   - 각각 상황에 따른 message 뿌려주기
   - DB에 유저가 없을 때 params[:email]로 DB를 검색하면 입력한 아이디가 존재하지 않습니다.라는 message가 뜬다. 
   - DB에 유저가 있으면 , 패스워드를 비교
     [패스워드가 맞으면] -> 로그인이 되었습니다.
     [패스워드가 틀리면] -> 패스워드가 틀렸습니다.
       라는 message가 뜬다.  

* [app/views/userinstas/login.erb]

```html
   <h1>로그인</h1>
   <%=form_tag '/userinsts/login_process', method:"post" do%>
       email: <%=text_field_tag :email%><br>
       password: <%=text_field_tag :password%><br>
       <%=submit_tag('로그인')%>
   <% end %>
   
```


 [app/controllers/userinstas_controller.rb]

```ruby
 def login
 end

 def login_process
   instauser = Instauser.find_by(email: params[:email])
   if instauser
     if instauser.password == params[:password]
       @msg = "로그인 성공"
       # redirect_to '/instas/index'
     else
       @msg = "비밀번호가 일치하지 않습니다."
       # redirect_to '/userinstas/login'
     end
   else 
     @msg = "먼저 회원가입을 해주세요."
     
   end
 end
         
```
</details>

- sign_up과 login같은 경우, Client로 부터 값을 받는 html form과 받은 값을 처리하는 process로 나누었다. 
- sign_up 프로세스에서는 회원가입 된 User 정보를 DB에 저장한다.
- login 프로세스에서는 DB에 저장된 값과 user한테 받은 값을 비교할 수 있어야 한다. 따라서 find_by함수를 사용해서 if문을 써서 상황설정을 해야한다.
- find_by(email: params[:email]) 라는 형식이다.


#### 8. User upgrade!

> - password 보안의 성능을 높여준다. 
> - 어떤 User정보를 저장할까? 
> - Login 했을 때를 생각해, user정보를 session값으로 저장하는데, 어떤 User정보를 session에 저장하는지도 중요하다. 

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. user를 session값에 저장해서 이용하면, user의 정보에 대한 보안성이 높아진다. 
---------------------------------------
password가 db에 저장된 값과 user가 입력한 값이 같을 경우, session에 해당하는 이메일을 가진 user의 id를 저장한다.

```ruby
session[:user_id] = instauser.id
```

2. logout
---------------------

```ruby
  def destroy
    session.clear
    redirect_to '/instas/index'
  end
```

3. Get방식 -> Post방식
-----------------------

* method = "post"라는 것은 post방식으로 방식으로 받는다는 것을 뜻한다. 개발을 하다보면 route error가 나는데, post로 온 통신을 post로 받지못할 경우 error가 난다. 
   <p style="color:red;">ActionController::InvalidAuthenticityToken</p>
   ActionController
   Understanding the Rails Authenticity Token

Since the authenticity token is stored in the session, the client cannot know its value. This prevents people from submitting forms to a Rails app without viewing the form within that app itself. 

- post 방식
- Authenticity Token
- session
- hidden field 
<br>
* get방식으로 값을 넘길 경우

- get방식으로 password같은 것을 처리했을 때 
- url로 값이 넘어오는 것이 다 보인다.
- https://도메인/userinstas/login_process?utf8=%E2%9C%93&email=a%40email.com&password=a&commit=%EB%A1%9C%EA%B7%B8%EC%9D%B8
- Query String Parameters에 값이 다 보인다. 
<br>
* Post 방식으로 값을 넘길 경우 => post로 바꿔준다.

- Request URL:

https://[도메인주소]/userinstas/login_process

- Request Method:

POST

- Url로는 값이 넘어오지 않는다. 
  https://[도메인주소]/userinstas/login_process
- 하지만, form action에서는 error가 난다.
  ActionController::InvalidAuthenticityToken 

```ruby
<form action='/userinstas/login_process', method="post">
email: <input type="email" name="email"><br>
password: <input type="password" name="password"><br>
<input type="submit" value="로그인">
```


액션 컨트롤러 쪽에서 Authenticity Token이라는 것을 요구하는데 그것이 없으면 발생하는 에러이다. 

form action으로 작성할 경우, authenticitytoken을 같이 넘겨줘야 한다.  

```ruby
<input type="hidden" name="authenticity_token" value="<%=form_authenticity_token()%>">
```

token값을 hidden값으로 넘겨주면 된다. 

```ruby
<form action='/userinstas/login_process', method="post">
email: <input type="email" name="email"><br>
password: <input type="password" name="password"><br>
<input type="hidden" name="authenticity_token" value="<%=form_authenticity_token()%>">
<input type="submit" value="로그인">
```

form_tag로 작성하면 authenticity_token을 따로 심어주지 않아도 된다. 

```ruby
<%=form_tag '/userinstas/login_process', method:"post" do%>
    email: <%=text_field_tag :email%><br>
    password: <%=text_field_tag :password%><br>
    <%=submit_tag('로그인')%>
<% end %>
```

</details>

#### 9. Model간의 관계

* has_many, belongs_to
* User는 여러개의 Images를 가질 수 있다.
* Image는 특정 User에게 속한다.

<details>

<summary><strong>Step-by-step(자세한 내용을 보려면 펼쳐주세요)</strong>

</summary>

1. user_id추가
------------------

```ruby
create_table :images do |t|
      t.integer :instauser_id
      t.string :image_url
      t.string :content
```

2. 관계설정
--------------------
[models/instauser.rb, image.rb]

```ruby
# models/instauser.rb
class Instauser < ActiveRecord::Base
    has_many :images
end

# models/image.rb
class Image < ActiveRecord::Base
    belongs_to :instauser
end

```

3. user_id가 안들어갈 경우, error가 나므로 꼭 login하고 Test하자.
-------------------

* session값이 어떻게 저장되어있는지 확인
* user_id도 params로 받을 수 있도록 설정

* [app/controllers/userinstas_controller #login_process]

```ruby
session[:user_id] = instauser.id
```

* [app/controllers/instas_controller #create]
```ruby
  def create
    Image.create(
      image_url: params[:image_url],
      content: params[:content],
      instauser_id: session[:user_id]
      )
      redirect_to '/instas/index'
  end
```

rails/db로 확인해 봤을 때 image_url과 content, id와 함께 instauser_id도 들어온다. 

4. User가 자신만의 게시물을 모두 확인할 수 있도록 하려고 한다.
-------------------------------
* 해당 user_id의 image를 확인할 수 있다.
* 로그인 session값을 이용해서, 자신이 쓴 게시물을 보여질 수 있도록 한다. 

```ruby
[5] pry(main)> Instauser.all
  Instauser Load (0.4ms)  SELECT "instausers".* FROM "instausers"
=> [#<Instauser:0x00000003b19600
  id: 1,
  email: "a@email.com",
  name: "a",
  password: "a",
  created_at: Sat, 25 Nov 2017 10:07:56 UTC +00:00,
  updated_at: Sat, 25 Nov 2017 10:07:56 UTC +00:00>,
 #<Instauser:0x00000003b18ea8
  id: 2,
  email: "b@email.com",
  name: "b",
  password: "b",
  created_at: Sat, 25 Nov 2017 10:09:13 UTC +00:00,
  updated_at: Sat, 25 Nov 2017 10:09:13 UTC +00:00>]


[15] pry(main)> Image.all

[17] pry(main)> Image.find_by(instauser_id: 1) 

[19] pry(main)> Instauser.find(1).images


```

* [app/views/intas #show.erb]

```html
<hr>
[내 게시물]<br>
<% @instauser.each do |i|%>
    <strong><%=i.id%>번째 img</strong><br>
    <%=image_tag i.image_url%><br>
    <strong>content: </strong>
    <%= i.content %>
    <%=link_to '[수정]', edit_insta_path(i.id) %><br>
<% end %>
```


</details>







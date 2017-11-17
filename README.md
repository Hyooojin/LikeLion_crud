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
# login
# login_process


2.


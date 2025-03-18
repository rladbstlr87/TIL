# BackEnd
- 뒷단
## CRUD
- 데이터베이스의 기본 뼈대
1. Create : 생성, 입력 (예: 사용자 등록)
2. Read : 읽기, 검색, 조회 (예: 게시글 보기)
3. Update : 수정, 갱신 (예: 프로필 수정)
4. Delete : 삭제 (예: 댓글 삭제)

### For example

#### Stage 1: Basic functionality
- C : `POST /users`
- R : `GET /users/{id}`
- U : `PUT /users/{id}`
- D : `DELETE /users/{id}`

#### Stage 2: Practical use cases
- `views.py`의 함수입장에서 보겠다
##### C
```py
# 사용자에게 입력받아서 제출 후 create()로 보내기
def new(request):
    return render(request, 'new.html')

# 입력받은 title과 content를 가져와서 DB에 저장 후 redirection해줌
def create(request):
    # 에러메시지에 request information 보고 가져오면 편함
    title = request.GET.get('title')
    content = request.GET.get('content')

    # DB에 저장하기
    post = Post()
    post.title = title # title에 들어온 값을 post.title 컬럼에 값을 채워넣는 역할
    post.content = content
    post.save() # 입력된 값들을 DB로 보내주는 역할

    return redirect(f'/posts/{post.id}/')
```
##### R
```py
# 게시글 본문 띄우기 / id는 게시글 id
def detail(request, id):
    post = Post.objects.get(id=id)

    context = {
        'post': post,
    }

    return render(request, 'detail.html', context)
```
##### U
```py
# 기존 게시글을 input란에 그대로 가져다놓고 수정할 수 있게하기
def edit(request, id):
    post = Post.objects.get(id=id)

    context = {
        'post': post,
    }
    return render(request, 'edit.html', context)

# 기존 게시글과 수정한 게시글 가져와서 덮어씌움(DB저장)
def update(request, id):
    # 기존 정보 가져오기
    post = Post.objects.get(id=id)

    # 새로운 정보 가져오기
    title = request.GET.get('title')
    content = request.GET.get('content')

    # 기존 정보를 새로운 정보로 덮어씌우기
    post.title = title
    post.content = content
    post.save()

    return redirect(f'/posts/{post.id}/')
```
##### D
```py
# 게시글 가져와서 삭제하고 posts 페이지로 보내기
def delete(request, id):
    post = Post.objects.get(id=id)
    post.delete()

    return redirect('/posts/')
```

### What it can do
- 데이터베이스 구조에 합당한 CRUD 설계는 성능을 최적화시킬 수 있다.


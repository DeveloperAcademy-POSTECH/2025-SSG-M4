## Adopting Liquid Glass to My App
![[adpoting-liquid-glass.png]]
지난 WWDC25에서, iOS ~ visionOS 26이 공개되었고 이번 업데이트에서는 [[Liquid Glass]]를 채용한 디자인 업데이트가 중심이 되었다. 

많은 개발자들은 (나를 포함한) '그래서 저걸 어떻게 적용하지...?' 라는 생각을 하였지만 다행히도 Apple은 Developer 문서에 [Adopting Liquid Glass](https://developer.apple.com/documentation/technologyoverviews/adopting-liquid-glass) 라는 문서를 제공해주었다. 

우선 문서를 보기 전, 이번 챌린지에서 우리 팀이 만들고 있던 App을 한번 기동해보았는데

![[iOS26-context.png|300]]
우리의 앱은 카메라 기능을 제외한 대부분은 [[SwiftUI]]를 사용하여 제작을 하였기에, 약간 보이기에 어색할수도 있으나 커스텀을 별도로 하지 않은 기본 컴포넌트들은 [[Liquid Glass]]에 맞는 새로운 스타일로 표시가 되는것을 볼 수 있었다. 

위의 스크린샷의 경우, 기존에는 
``.confirmationDialog(_:isPresented:titleVisibility:presenting:actions:)`` 를 사용하고 있었으나 (흔히들 Action Sheets라고 부르는) iOS 26에서 구동을 하자 Alert와 ActionSheets를 조합한 새로운 디자인으로 표시되는것을 확인할 수 있었다.

이런 경우에는, 바뀐 디자인이 어색해보일수는 있으나 앱의 사용성을 저해하거나 동작을 하지 않는 수준은 아니기때문에 급하게 수정을 할 필요는 없다.

그러나, 문제는 ``.fullScreenCover(isPresented:onDismiss:content:)`` 에서 발생했다.

![[iOS26-record.png|300]]
기존에는, '과정 기록하기' 페이지로 이동 할 경우 '작성 완료'를 하면 다시 메인화면으로 돌아와야 하기 때문에 새로운 페이지로 이동하는것이 아닌, 메인 화면 위에

```Swift
.fullScreenCover(isPresented: $showCreate) {
	CreateView(
		createPickedImage: $mainPickedImage,
        initialProject: currentProject
    )
}
```

다음과 같이 전체 화면을 덮는 모달을 호출하여 마치 다음 페이지로 넘어간것과 같이 보이는 방식을 사용하고 있었다.

그러면, 모달을 사용하는 다른 화면은 어떻게 나올까?

![[iOS26-profile.png|300]]
마찬가지로, 이 화면 또한 ``.fullScreenCover()``를 사용한 모달을 사용하고 있었기에 제대로 표시되지 않는것을 확인할 수 있었다.

그러나, 동일한 모달이지만 

![[iOS26-comment.png|300]]

댓글을 작성하는 Comment Modal은, 정상적으로 보이는것을 확인할 수 있었다. 

코드를 확인해보면

```Swift
LikeCommentBar(post: post, commentCount: comments.count, onCommentTap: {showCommentModal = true})
	.sheet(isPresented: $showCommentModal, onDismiss: {post.comments = comments try? modelContext.save()}) 
	{CommentModal(comments: $comments)
		.presentationDetents([.medium])
		.presentationDragIndicator(.visible)
	}
```

과 같이, 모달을 호출하는 방식이 약간 다른것을 확인할 수 있다.

그러면, ``.sheet()``와 ``.fullScreenCover()`` 때문에 이런 차이가 발생하는걸까?

```Swift
.sheet(isPresented: $showCreate) {
	CreateView(
	...
	)
	.presentationDetenst([.large])
}
```

위처럼 바꾸고 실행을 해보니

![[iOS18-record.png|300]]
iOS 26이 아닌, iOS 18로 돌아왔다. 
sheet뿐만이 아니라, 다른 요소들도 마찬가지다.  

TestFlight를 통해서 배포받은 App -> 컴포넌트가 iOS 26에 맞추어서 변화
Xcode를 통해서 배포받은 App -> iOS 26이나, 컴포넌트는 iOS 18 그대로

TestFlight를 통한 배포과정과 Xcode를 통한 배포에 어떤 차이가 있는것일까?

macOS 26과 Xcode 26을 설치해보지 않는 이상 테스트는 불가능하게 되었다...

그러면 다시 원래대로 돌아가서, ``.fullScreenCover()``와 ``.sheet()`` 는 비슷하지만 (사실 외형도 다르지만) iOS 26에 넘어와서는 동작성도 바뀌게 된것을 확인할 수 있었다.

하지만 과연, 호출 방식의 차이라고 할 수 있을까?

기록하기는 ``CreateView``을 실행하고, 댓글은 ``CommentModal``을 실행하는데 그러면 이제 두 View를 비교해보면

우선 ``CreateView``에는 배경색이 지정되어있지 않다. 그렇기에, System에서 기본적으로 사용하고있는 기본 배경색을 가지고온다. 

``CommentModal``의 경우, ``CommentModal``의 전체를 덮는 ``VStack``에 ``.background(.grayWhite)``로 지정이 되어있다.

즉, 단순히 ``.fullScreenCover()``여서 투명하게 보이고 ``.sheet()``여서 제대로 보이는것이 아닌

iOS 26의 [[Liquid Glass]]가 적용되며, 전체적으로 투명한 배경이 버튼, 시트, 경고와 같은 부분에 적용이 되었기에 마찬가지로 ``.fullScreenCover()``에서도 그대로 적용된것이 아닐까...? 라고 추측해본다. 


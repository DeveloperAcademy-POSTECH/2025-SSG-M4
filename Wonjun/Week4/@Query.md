@Query는 SwiftUI 뷰에서만 사용되는 SwiftData의 모델 데이터를 쉽고 안전하게 가져오기 위해 Apple이 직접 제공하는 [[프로퍼티 래퍼]]이다. 

예제
```swift
@Query(filter: #Predicate<Book> { $0.title.contains("test") },
//Book모델의 title프로퍼티에 test라는 문자열이 포함된 데이터만 가져옵니다
       sort: [SortDescriptor(\.createdDate)])
//createdDate 프로퍼티를 기준으로 오름차순(기본값)으로 정렬합니다

var books: [Book]
//조건에 맞는 데이터가 담길 배열
```


**특징**: 
1. 쿼리 조건(필터, 정렬)은 뷰 초기화 시점에만 지정
	1. 동적으로 조건을 바꾸려면 뷰를 새로 생성하거나, 커스텀 뷰로 감싸야 한다.
2. [[데이터 변경]] 감지 및 자동 뷰 갱신
	1. 데이터가 추가, 수정, 삭제되면 @Query로 선언한 배열이 자동으로 갱신되고, 뷰도 자동으로 다시 그려진다.
3. 타입 안전성과 컴파일 타임 검사
	1. Predicate와 SortDescriptor를 사용해, 쿼리 조건을 [[컴파일 타임]]에 검사할 수 있다.
4. @Bindable과의 차이
	1. @Query: 데이터베이스에서 데이터를 가져와 뷰에 바인딩(자동 갱신)한다.
	2. @Bindable: **단일** 모델 객체의 속성 변경을 뷰에 바인딩(주로 수정 화면에서 사용)한다.
		\*바인딩: 양방향 연결

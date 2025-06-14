@Query는 SwiftUI 뷰에서 사용되는 SwiftData의 모델 데이터를 쉽고 안전하게 가져오기 위한 [[프로퍼티 래퍼]]이다. 

특징: SwiftUI 뷰에서 데이터베이스 Query(필터, 정렬등)을 직접 선언할 수 있고, 데이터가 변경될 때마다 뷰가 자동으로 업데이트됩니다.

선언
```swift
@Query(filter: #Predicate<Book> { $0.title.contains("test") },
//Book모델의 title프로퍼티에 test라는 문자열이 포함된 데이터만 가져옵니다
       sort: [SortDescriptor(\.createdDate)])
	   //createdDate 프로퍼티를 기준으로 오름차순(기본값)으로 정렬

var books: [Book]
//조건에 맞는 데이터가 담길 배열
```


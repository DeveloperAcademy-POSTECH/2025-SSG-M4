Query는 데이터 베이스에서 원하는 데이터를 조건에 맞게 읽어오는 작업을 의미한다. ([[@Query]]랑 다름!)

SwiftData Query의 주요 구성 요소
1. [[FetchDescriptor]]: 데이터를 가져올 조건 정의
	1. Predicate
	2. SortDescriptor
```swift
let predicate = #Predicate<Book> { $0.title.contains("test") }
let sort = SortDescriptor(\.createdDate)
let descriptor = FetchDescriptor<Book>(predicate: predicate, sortBy: [sort])
let books = try context.fetch(descriptor)
```

2. [[@Query]]: SwiftUI 뷰에서 쿼리 조건을 직접 선언하고 데이터 변경 시 뷰가 자동으로 갱신
	1. Predicate
	2. SortDescriptor
```swift
@Query(filter: #Predicate<Book> { $0.title.contains("test") },
       sort: [SortDescriptor(\.createdDate)])
var books: [Book]
```

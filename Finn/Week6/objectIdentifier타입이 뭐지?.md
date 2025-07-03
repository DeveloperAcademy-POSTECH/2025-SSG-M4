>[! 정의]
클래스 인스턴스(참조 타입)의 메모리 주소를 기반으로 하는 고유한 식별자 
### 그럼 참조 타입이라했으면 값타입인 Struct는 상관이 없는 친구인건가요??

#### 정답 !
>[! 공식문서 ]
>[`ObjectIdentifier` ](https://developer.apple.com/documentation/swift/objectidentifier) 
>In Swift, only class instances and metatypes have unique identities. There is no notion of identity for structs, enums, functions, or tuples.
>**해석**
>인스턴스 수명 동안의 비교에만 유효합니다. Swift에서는 클래스 인스턴스와 메타타입만 고유한 식별자를 갖습니다

근데 왜 이런 차이가 발생했을까? 근데 값타입과 참조타입의 특성을 들여다보면 당연한 이야기 일 수 있다. 

[[값타입 vs 참조타입]]
----
>이미 존재하는 타입을 다른 이름으로 정의하는 것
- `typealias` 키워드 사용
- 상황에 맞는 이름으로 기존 타입을 참조하려는 경우 유용
	- Ex) 외부 소스에서 특정 크기의 데이터로 작업 시
```
typealias AudioSample = UInt16
```
- 원래 이름을 사용할 수 있는 모든 위치에서 별칭 사용 가능
```
var maxAmlitudeFound = AudioSample.min // UInt16.min -> 0
```
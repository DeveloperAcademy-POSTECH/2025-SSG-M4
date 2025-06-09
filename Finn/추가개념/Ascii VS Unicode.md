

- **ASCII**는 옛날 컴퓨터가 영어만 처리하던 시절의 문자 표준
- **Unicode**는 전세계 모든 문자를 다 담으려고 만든 현대 표준 
```swift
// ASCII 시절 (영어만)
let 아스키시절 = "Hello123"

// Unicode 시대 (뭐든지)
let 유니코드 = "Hello안녕こんにちは🎉"
print(유니코드)
```

- Swift 소스 파일이 인코딩 방식이 `UTF-8`이라서 이모지 같은거도 자유롭게 사용할 수 있음 ! 

### 특징 차이 

- **ASCII**: 고작 128개 (확장해봐야 256개)
    - 영문 알파벳 + 숫자 + 기본 특수문자 정도
- **Unicode**: 현재 149,000개 이상 (계속 늘어나는 중)
    - 한글, 일본어, 중국어, 이모지, 고대 문자까지 다 있음

>[! 핵심]
>ASCII는 Unicode에 포함되는 친구 
### 숫자들은 어떻게 저장되나?


```swift title:Ascii->Unicode 
// ASCII와 Unicode 모두 동일
'0' → 48 (0x30)
'1' → 49 (0x31)
'2' → 50 (0x32)
...
'9' → 57 (0x39)
```

이래서 `Character`를 숫자로 바꿀 때 `-48` 하는 트릭이 먹히는 것 ! 

```swift
let char: Character = "7"
let unicodeValue = char.unicodeScalars.first!.value // 55
let digit = unicodeValue - 48 // 7

// wholeNumberValue가 내부적으로 하는 일  -48 쳐주기
```
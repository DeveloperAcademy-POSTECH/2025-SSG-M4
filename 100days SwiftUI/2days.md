# 불리언(Boolean)이란 무엇인가요?

불리언은 `true`(참) 또는 `false`(거짓)라는 두 가지 가능한 값 중 하나만 저장할 수 있는 매우 단순한 데이터 타입입니다. 이는 어떤 것이 정확한지 아닌지, 켜져 있는지 꺼져 있는지, 예 또는 아니오와 같은 논리적 상태를 나타내는 데 사용됩니다. "불리언"이라는 이름은 논리학에 대해 광범위하게 연구한 영국의 수학자 조지 불(George Boole)의 이름에서 유래했습니다.

여러분은 이미 `hasSuffix()`(문자열이 특정 문자 시퀀스로 끝나는지 확인)나 `isMultiple(of:)`(숫자가 다른 숫자의 배수인지 확인)와 같은 함수를 사용하면서 불리언을 접해 보셨을 겁니다. 이러한 함수들은 `true` 또는 `false`를 반환합니다.

**불리언은 어떻게 만드나요?**

불리언 변수나 상수는 `true` 또는 `false` 중 하나의 초기 값을 할당하여 만듭니다.

예를 들어:

Swift

```
let goodDogs = true
let gameOver = false
```

또한, `true` 또는 `false`로 평가되는 연산이나 함수의 결과를 할당하여 불리언을 만들 수도 있습니다.

예를 들어:

Swift

```
let filename = "paris.jpg"
let isJPEG = filename.hasSuffix(".jpg") // isJPEG는 true가 됩니다.

let number = 120
let isMultipleOfThree = number.isMultiple(of: 3) // isMultipleOfThree는 true가 됩니다.
```

이 경우, `isJPEG`와 `isMultipleOfThree`는 `hasSuffix()`와 `isMultiple(of:)`가 불리언 값을 반환하기 때문에 불리언이 됩니다.

**불리언의 값은 어떻게 변경하나요?**

불리언이 변수(`var`를 사용)로 선언된 경우, 그 값을 변경할 수 있습니다. 설명된 두 가지 주요 방법이 있습니다.

1. **"not" 연산자 (`!`) 사용하기**: 이 연산자는 불리언의 값을 반전시킵니다. `true`이면 `false`가 되고, `false`이면 `true`가 됩니다.
    
    예를 들어:
    
    Swift
    
    ```
    var isAuthenticated = false
    print(isAuthenticated) // 출력: false
    
    isAuthenticated = !isAuthenticated // isAuthenticated는 이제 true입니다.
    print(isAuthenticated) // 출력: true
    
    isAuthenticated = !isAuthenticated // isAuthenticated는 이제 다시 false입니다.
    print(isAuthenticated) // 출력: false
    ```
    
2. **`toggle()` 메소드 사용하기**: 이 메소드 또한 `!` 연산자처럼 불리언의 값을 반전시키지만, 복잡한 코드에서 때때로 더 편리할 수 있습니다.
    
    예를 들어:
    
    Swift
    
    ```
    var gameIsOver = false
    print(gameIsOver) // 출력: false
    
    gameIsOver.toggle() // gameIsOver는 이제 true입니다.
    print(gameIsOver) // 출력: true
    ```
    

불리언에는 `true + true`와 같은 연산이 논리적으로 의미가 없기 때문에 `+`나 `-`와 같은 산술 연산자가 없다는 점에 유의하는 것이 중요합니다.

---

# Swift 핵심 개념 정리 (Swift in Sixty Seconds 발췌)

---

## 1. 상수 (Constants) - `let`

- **변수 (`var`)**: 시간이 지남에 따라 값이 변할 수 있음.
- **상수 (`let`)**: 값을 한 번 설정하면 **절대 바꿀 수 없음**.
  - `var` 키워드의 대안.
  - 예시: `let taylor = "swift"`
  - 만약 `taylor = "new value"` 와 같이 변경 시도 시, Xcode는 코드 실행을 **거부**.
- **장점 (안전 장치)**:
  - 실수로 값을 변경하는 것을 방지.
  - 코드를 작성할 때, 값이 특별히 변경되어야 하는 경우가 아니라면 **항상 `let`을 사용**하는 것이 좋음.
- **Xcode의 경고**:
  - `var`로 선언했지만 값을 변경하지 않는 경우, Xcode는 `let`으로 바꾸라는 경고를 표시함.

---

## 2. Double과 Boolean (기본 데이터 타입)

### Double
- **정의**: `Double Precision Floating Point Number`의 줄임말.
- **용도**: 소수점 값을 표현 (예: `38.1`, `3.141592654`).
- **타입 추론**: 소수점 숫자로 변수를 생성하면 Swift는 자동으로 해당 변수에 `Double` 타입을 부여.
  - 예시: `var pi = 3.141` (pi는 `Double` 타입)
- **주의**: `Double`은 정수(`Int`)와 다르므로, 실수로 두 타입을 섞어 사용할 수 없음.

### Boolean (Bool)
- **정의**: `true` 또는 `false` 값만 가짐.
- **타입 추론**: `true` 또는 `false`로 할당된 모든 변수에 Swift는 자동으로 `Boolean` (축약형: `Bool`) 타입을 할당.
  - 예시: `var awesome = true` (awesome은 `Bool` 타입)
- **축약형**: `Bool`

---

## 3. 여러 줄 문자열 (Multi-line Strings)

- **표준 문자열**: 큰따옴표 (`"`)를 사용하며, 그 안에 줄 바꿈을 직접 포함할 수 없음.
- **여러 줄 문자열 문법**:
  - 세 개의 큰따옴표 (`"""`)로 시작하고 끝냄.
  - **여는 세 개의 따옴표 (`"""`)**와 **닫는 세 개의 따옴표 (`"""`)**는 **반드시 각자의 줄에 있어야 함.**
  - 여는 줄 바꿈과 닫는 줄 바꿈은 최종 문자열에 포함되지 않음.
  - 예시:
    ```swift
    let multiLineString = """
    This string
    goes over
    multiple lines.
    """
    // 결과: "This string\ngoes over\nmultiple lines."
    ```
- **줄 바꿈 없이 코드 포맷팅**:
  - 여러 줄 문자열을 코드 가독성을 위해 사용하되, 실제 문자열에는 줄 바꿈을 포함하고 싶지 않다면 각 줄 끝에 백슬래시 (`\`)를 사용.
  - 예시:
    ```swift
    let continuousString = """
    This goes \
    over multiple \
    lines.
    """
    // 결과: "This goes over multiple lines."
    ```

---

## 4. 문자열 보간 (String Interpolation)

- **정의**: 변수나 상수의 값을 문자열 안에 직접 삽입하여 동적인 문자열을 만드는 기능.
- **문법**: 백슬래시 (`\`) 뒤에 변수/상수 이름을 괄호 `()` 안에 작성. `\(expression)`
- **특징**:
  - 어떤 타입의 변수/상수라도 문자열 안에 배치 가능.
  - 필요한 만큼 여러 번 사용 가능.
  - 문자열로부터 또 다른 문자열을 만들 때도 유용.
- **예시**:
  ```swift
  var score = 85
  var str = "Your score was \(score)"
  // str의 값: "Your score was 85"

  var results = "The test results are here: \(str)"
  // results의 값: "The test results are here: Your score was 85"
```


---

## 5. 문자열과 정수 (Strings and Integers) – 타입 안전성

- Swift는 **타입 안전(type safe)** 언어입니다.
  - 이는 모든 변수가 하나의 특정 타입을 가져야 함을 의미합니다.
- **문자열 (`String`)**:
  - 예시: `Xcode`가 자동으로 생성해 준 `str` 변수는 `"hello playground"`라는 문자열을 담고 있으므로 Swift는 `String` 타입을 할당합니다.
- **정수 (`Int`)**:
  - 예시: 누군가의 나이를 저장하고 싶다면 `var age = 38`과 같이 변수를 만들 수 있습니다.
  - 이것은 **정수(whole number)**를 담고 있으므로 Swift는 `Int` 타입 (Integer의 줄임말)을 할당합니다.
- **큰 숫자 표현**:
  - Swift는 큰 숫자가 있을 경우, 가독성을 위해 천 단위 구분 기호로 밑줄 (`_`)을 사용할 수 있도록 허용합니다.
  - 이 밑줄은 숫자의 실제 값을 변경하지 않으며, 읽기 쉽게 만들어 줍니다.
  - 예시: `var population = 8_000_000` (8백만을 의미)
- **타입 간 호환성**:
  - `String`과 `Int`는 서로 다른 타입이며, 일반적으로 직접 혼합될 수 없습니다.
  - 예시:
    - `str = "goodbye"` (O) – `str`은 `String` 타입이므로 문자열 할당 가능.
    - `str = 38` (X) – `38`은 `Int` 타입이므로 `String` 타입인 `str`에 할당 시 오류 발생.

---

## 6. 타입 명시 (Type Annotations) vs 타입 추론 (Type Inference)

- **타입 추론 (Type Inference)**:
  - Swift는 변수나 상수에 생성 시 어떤 값이 주어지는지에 따라 타입을 **자동으로 할당**합니다.
  - 예시: `let str = "hello playground"` 코드를 작성하면, Swift는 이 변수가 문자열을 담고 있음을 알 수 있습니다.
  - Swift는 `str`을 `String`으로 만들기 때문에, 나중에 정수나 `Boolean` 값을 할당하려고 시도할 수 없습니다.
  - 이것을 **타입 추론(Type Inference)**이라고 하며, Swift는 어떻게 생성되었는지에 기반하여 어떤 것의 타입을 추론할 수 있습니다.
- **타입 명시 (Type Annotations)**:
  - Swift의 타입 추론에 의존하는 대신, 데이터의 타입을 **명시적으로 지정**하고 싶을 때 사용합니다.
  - 문법: `let/var 변수명: 타입 = 초기값`
  - 예시:
    ```swift
    let album: String = "Reputation"
    let year: Int = 1989
    let height: Double = 1.78
    let taylorRocks: Bool = true
    ```
- **`Bool` 타입**:
  - `Boolean` 값 (`true` 또는 `false`)을 위한 타입입니다.
  - 정수가 짧은 타입 이름 `Int`를 가졌던 것과 같은 방식으로 `Bool`이라는 짧은 타입 이름을 가집니다.

---

## 7. 변수 (Variables) – `var` 키워드 및 Playground 소개

- **Xcode Playground 시작하기**:
  - Xcode를 실행하면 무엇을 하고 싶은지 물어볼 때, **"get started with a playground"**를 선택하는 것이 좋습니다.
  - Playground는 Swift 코드를 입력하고 즉각적인 결과를 볼 수 있는 **샌드박스(sandbox)**와 같은 곳입니다.
  - 기본 설정은 iOS용 빈 Playground이며, 이것으로 충분합니다.
  - `Next`를 클릭한 다음 `create`를 눌러 (예: 바탕화면에) 저장하면 됩니다.
- **변수 (Variables) 소개**:
  - 이 영상에서 소개하려는 것은 바로 **변수(variables)**입니다.
  - 변수는 프로그램 데이터를 저장할 수 있는 공간입니다.
  - 값이 '변할 수(vary)' 있기 때문에 변수(variables)라고 불리며, 값을 자유롭게 변경할 수 있습니다.
- **변수 생성 및 초기화**:
  - Playgrounds는 보통 우리를 위해 변수를 생성하는 한 줄의 코드로 시작합니다:
    ```swift
    var str = "hello playground"
    ```
  - 위 코드는 `str`이라는 새로운 변수를 만들고 `"hello playground"`라는 값을 부여(할당)합니다.
  - Playground의 오른쪽 출력 영역에서 할당된 값 (`"hello playground"`)을 볼 수 있습니다. (Xcode가 설정된 값을 보여주는 것)
- **변수의 값 변경**:
  - `str`이 변수이기 때문에 값을 변경할 수 있습니다.
  - 예시: `str = "goodbye"`
- **값 변경 시 `var` 키워드**:
  - 변수의 값을 두 번째로 변경할 때는 `var` 키워드가 **필요하지 않습니다.**
  - 그 이유는 변수는 이미 (`var`를 통해) 생성되었고, 우리는 그저 그 변수의 값을 변경하고 있을 뿐이기 때문입니다.

---

**태그:** #Swift #프로그래밍 #변수 #타입안전성 #타입추론 #타입명시 #String #Int #Bool #Playground #Xcode


45
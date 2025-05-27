# Swift 배열 마스터하기 🚀

Swift에서 배열은 순서가 있는 값의 목록을 저장하는 강력하고 일반적인 컬렉션 타입입니다. 동일한 타입의 여러 데이터를 하나의 변수에 그룹화하여 효율적으로 관리할 수 있게 해줍니다.

---

## 1. 배열이란 무엇인가? (What are Arrays?)

배열은 동일한 타입의 값들이 순서대로 저장된 컬렉션입니다. 첫 번째 항목은 인덱스 0, 두 번째는 인덱스 1, 이런 식으로 번호가 매겨집니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **순서가 있는 컬렉션 (Ordered Collection)**: 배열에 저장된 항목들은 사용자가 추가한 순서대로 유지됩니다. 이 순서는 변경되지 않으며, 각 항목은 고유한 인덱스(위치 번호)를 가집니다.
* **동일 타입 요소 (Homogeneous Elements)**: Swift 배열은 타입에 안전(type-safe)합니다. 즉, 하나의 배열에는 **단일 타입**의 데이터만 저장할 수 있습니다. 예를 들어, 정수 배열에는 정수만, 문자열 배열에는 문자열만 저장할 수 있습니다. (예외적으로 `Any` 타입을 사용할 수 있지만, 권장되지는 않습니다. 아래 '타입 안전성' 섹션 참조)
* **값 타입 (Value Type)**: 배열은 Swift에서 값 타입입니다. 이는 배열을 새로운 변수에 할당하거나 함수에 전달할 때, 배열의 복사본이 생성된다는 의미입니다. 원본 배열과 복사본은 서로 독립적입니다.
    * **예시**:
        ```swift
        var originalArray = [1, 2, 3]
        var copiedArray = originalArray // 복사본 생성
        copiedArray.append(4)

        print(originalArray) // [1, 2, 3] 출력 (원본 불변)
        print(copiedArray)  // [1, 2, 3, 4] 출력
        ```

### ✨ 구체적인 예시 (Specific Examples)

제공된 예시 외에 다양한 타입의 배열을 만들 수 있습니다.

* **Boolean 배열**:
    ```swift
    var taskCompletedStatus = [true, false, true, true, false]
    ```
* **Tuple 배열**:
    ```swift
    var studentRecords: [(name: String, score: Int)] = [("Alice", 90), ("Bob", 85), ("Charlie", 92)]
    print(studentRecords[0].name) // "Alice"
    ```
* **빈 배열 선언의 다양한 방법**:
    ```swift
    var emptyStrings = [String]() // 타입 명시, 선호되는 방식
    var emptyIntegers: [Int] = [] // 타입 어노테이션과 빈 리터럴
    var emptyDoubles = Array<Double>() // 제네릭 구문
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **다른 컬렉션 타입 (Other Collection Types)**:
    * **Set**: 순서가 없고, 중복된 값을 허용하지 않는 컬렉션입니다.
    * **Dictionary**: 순서가 없는 키-값 쌍의 컬렉션입니다.
* **튜플 (Tuples)**: 고정된 개수의 여러 타입 값을 그룹화하는 데 사용됩니다. 배열과 달리 튜플은 타입이 다른 요소들을 가질 수 있고, 요소의 개수가 고정됩니다.

---

## 2. 배열 생성 및 초기화 (Creating and Initializing Arrays)

배열은 리터럴을 사용하거나, 특정 타입을 지정하여 빈 배열로, 또는 기본값으로 채워진 배열로 생성할 수 있습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **리터럴을 사용한 생성**: `let numbers = [1, 2, 3]` 처럼 대괄호 `[]` 안에 값을 나열하여 간단히 생성합니다. Swift는 이때 타입을 추론합니다.
* **빈 배열 생성**:
    * `var emptyArray = [ElementType]()` (예: `var names = [String]()`)
    * `var emptyArray: [ElementType] = []` (예: `var ages: [Int] = []`)
* **특정 값으로 배열 채우기 (`Array(repeating:count:)`)**: 동일한 값을 여러 번 반복하여 배열을 초기화할 때 유용합니다.
    ```swift
    // 0.0 값을 5번 반복하여 배열 생성
    var defaultScores = Array(repeating: 0.0, count: 5) // [0.0, 0.0, 0.0, 0.0, 0.0]
    print(defaultScores)

    // "Pending" 문자열을 3번 반복
    var statusMessages = Array(repeating: "Pending", count: 3) // ["Pending", "Pending", "Pending"]
    print(statusMessages)
    ```

### ✨ 구체적인 예시 (Specific Examples)

* **`Array(repeating:count:)` 사용 예시**:
    ```swift
    // 게임 보드의 초기 상태 (모든 칸을 빈칸으로)
    let initialBoardRow = Array(repeating: "⬜️", count: 3)
    print(initialBoardRow) // ["⬜️", "⬜️", "⬜️"]
    ```
* **다차원 배열 (2D Arrays)**: 배열의 요소로 또 다른 배열을 가질 수 있습니다. (자세한 내용은 아래 '다차원 배열' 섹션 참조)
    ```swift
    var matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    print(matrix[0][1]) // 2 출력 (첫 번째 배열의 두 번째 요소)
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **생성자 (Initializers)**: `Array<ElementType>()`나 `Array(repeating:count:)`는 배열 타입의 생성자를 호출하는 예입니다.
* **타입 추론 (Type Inference)**: Swift는 배열 리터럴로부터 타입을 자동으로 유추할 수 있는 강력한 기능을 제공합니다. `let values = [1, 2, 3]`에서 Swift는 `values`가 `[Int]` 타입임을 압니다.

---

## 3. 배열 요소 접근 (Accessing Array Elements)

배열의 각 요소는 0부터 시작하는 인덱스를 통해 접근합니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **인덱스 (Index)**: `array[index]` 구문을 사용합니다. `beatles[0]`은 첫 번째 요소, `numbers[1]`은 두 번째 요소입니다.
* **주의: 인덱스 범위 초과 (Index Out of Bounds)**: 존재하지 않는 인덱스로 배열 요소에 접근하려고 하면 런타임 오류(crash)가 발생합니다. 항상 인덱스가 배열의 유효한 범위 내에 있는지 확인해야 합니다.
    * 유효한 인덱스 범위: `0` 부터 `array.count - 1` 까지.
* **안전한 접근 방법**:
    * **`first` 프로퍼티**: 배열의 첫 번째 요소를 옵셔널로 반환합니다. 배열이 비어있으면 `nil`을 반환하여 안전합니다.
    * **`last` 프로퍼티**: 배열의 마지막 요소를 옵셔널로 반환합니다. 배열이 비어있으면 `nil`을 반환합니다.
    * **`isEmpty` 프로퍼티**: 배열이 비어있는지 여부를 `Bool` 값으로 반환합니다. 접근 전에 확인하여 오류를 방지할 수 있습니다.
    ```swift
    let names = ["Alice", "Bob", "Charlie"]
    if !names.isEmpty && names.count > 0 {
        print("첫 번째 이름: \(names[0])") // 안전하게 접근
    }

    if let firstName = names.first {
        print("첫 번째 이름 (옵셔널 바인딩): \(firstName)")
    } else {
        print("배열이 비어있습니다.")
    }
    ```

### ✨ 구체적인 예시 (Specific Examples)

* **`first`와 `last` 사용**:
    ```swift
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    print(weekdays.first ?? "요일 없음") // "Monday"
    print(weekdays.last ?? "요일 없음")  // "Friday"

    let emptySchedule: [String] = []
    print(emptySchedule.first ?? "일정 없음") // "일정 없음"
    ```
* **인덱스 범위 확인 후 접근**:
    ```swift
    let scores = [88, 92, 75]
    let indexToAccess = 1
    if indexToAccess >= 0 && indexToAccess < scores.count {
        print("점수: \(scores[indexToAccess])") // "점수: 92"
    } else {
        print("잘못된 인덱스입니다.")
    }
    ```
* **부분 배열 (Subscripting with a Range)**:
    ```swift
    let numbers = [0, 1, 2, 3, 4, 5]
    let subArray = numbers[1...3] // [1, 2, 3] (ArraySlice 반환)
    print(Array(subArray))     // Array로 변환하여 사용 가능
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **옵셔널 (Optionals)**: `first`, `last` 와 같은 메서드는 요소가 없을 가능성이 있으므로 옵셔널 타입을 반환합니다. 옵셔널 바인딩(`if let`)이나 기본값 연산자(`??`)를 사용하여 안전하게 값을 추출해야 합니다.
* **반복문 (Loops)**: `for-in` 루프 등을 사용하여 배열의 모든 요소를 순차적으로 접근(순회)할 수 있습니다.
    ```swift
    for beatle in beatles {
        print(beatle)
    }
    ```

---

## 4. 배열 수정 (Modifying Arrays)

`var`로 선언된 가변 배열은 생성 후에도 요소를 추가, 삽입, 삭제할 수 있습니다. `let`으로 선언된 불변 배열은 수정할 수 없습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **`append(_:)`**: 배열의 맨 끝에 새 요소를 추가합니다.
* **`append(contentsOf:)`**: 다른 배열(또는 시퀀스)의 모든 요소를 배열 끝에 추가합니다.
* **`insert(_:at:)`**: 지정된 인덱스에 새 요소를 삽입합니다. 기존 요소들은 뒤로 밀려납니다.
* **`remove(at:)`**: 지정된 인덱스의 요소를 삭제하고 반환합니다. 뒤의 요소들이 앞으로 당겨집니다.
* **`removeLast()`**: 배열의 마지막 요소를 삭제하고 반환합니다. 배열이 비어있으면 오류가 발생하므로 주의해야 합니다.
* **`removeFirst()`**: 배열의 첫 번째 요소를 삭제하고 반환합니다. 배열이 비어있으면 오류가 발생하므로 주의해야 합니다.
* **`removeAll()`**: 배열의 모든 요소를 삭제합니다.
* **`+=` 연산자**: 두 배열을 결합하여 기존 배열에 추가합니다.
    ```swift
    var listA = [1, 2]
    let listB = [3, 4]
    listA += listB // listA는 이제 [1, 2, 3, 4]
    ```

### ✨ 구체적인 예시 (Specific Examples)

* **`insert(at:)` 사용**:
    ```swift
    var colors = ["Red", "Green", "Blue"]
    colors.insert("Yellow", at: 1) // ["Red", "Yellow", "Green", "Blue"]
    print(colors)
    ```
* **`removeLast()` 및 `removeFirst()` 사용**:
    ```swift
    var playlist = ["SongA", "SongB", "SongC", "SongD"]
    let lastSong = playlist.removeLast() // "SongD" 반환, playlist는 ["SongA", "SongB", "SongC"]
    print("Removed last song: \(lastSong)")
    let firstSong = playlist.removeFirst() // "SongA" 반환, playlist는 ["SongB", "SongC"]
    print("Removed first song: \(firstSong)")
    print("Current playlist: \(playlist)")
    ```
* **`+=` 연산자로 배열 결합**:
    ```swift
    var morningTasks = ["Wake up", "Brush teeth"]
    let eveningTasks = ["Read a book", "Sleep"]
    morningTasks += eveningTasks
    print(morningTasks) // ["Wake up", "Brush teeth", "Read a book", "Sleep"]
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **가변성 (`var` vs `let`)**: 배열을 수정하려면 `var` 키워드로 선언해야 합니다. `let`으로 선언된 배열은 불변(immutable)이므로 크기나 내용을 변경할 수 없습니다.
* **시간 복잡도 (Time Complexity)**: 각 배열 연산은 서로 다른 성능 특성을 가집니다. 예를 들어, `append()`는 보통 빠르지만(`O(1)` amortized), `insert(at: 0)` (맨 앞에 삽입)이나 `remove(at: 0)` (맨 앞 삭제)는 모든 요소를 이동시켜야 하므로 상대적으로 느릴 수 있습니다(`O(n)`).

---

## 5. 타입 안전성 (Type Safety)

Swift는 타입에 매우 엄격하며, 배열도 예외는 아닙니다. 한 번 타입이 결정된 배열에는 해당 타입의 값만 추가할 수 있습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **컴파일 시 타입 체크**: Swift 컴파일러는 배열에 잘못된 타입의 값을 추가하려고 하면 오류를 발생시킵니다. 이는 런타임에 발생할 수 있는 많은 오류를 미리 방지해줍니다.
    ```swift
    var temperatures = [25.3, 28.2, 26.4] // [Double] 타입으로 추론됨
    // temperatures.append("Chris") // 컴파일 오류! Double 배열에 String을 추가할 수 없음
    ```
* **`Any` 타입을 사용한 이종(heterogeneous) 배열**: 드물지만, 하나의 배열에 여러 타입의 값을 저장해야 할 경우 `[Any]` 타입을 사용할 수 있습니다. 하지만 이는 타입 안전성의 이점을 잃게 되므로, 가급적 피하는 것이 좋습니다. `Any` 타입의 배열에서 요소를 사용하려면 타입 캐스팅(`as?`, `as!`)이 필요합니다.
    ```swift
    var mixedArray: [Any] = ["Hello", 42, 3.14, true]
    if let firstItem = mixedArray[0] as? String {
        print("첫 번째 항목 (문자열): \(firstItem.uppercased())") // HELLO
    }
    if let secondItem = mixedArray[1] as? Int {
        print("두 번째 항목 (정수): \(secondItem + 10)") // 52
    }
    ```
    **주의**: `Any`를 사용하면 컴파일 시점에 타입 오류를 잡을 수 없고, 런타임에 타입 캐스팅 실패로 인한 오류가 발생할 수 있습니다.

### 🔗 연관 학습 내용 (Related Learning)

* **제네릭 (Generics)**: `Array<Element>` 에서 `Element`는 타입 매개변수입니다. 제네릭 덕분에 배열은 어떤 특정 타입 `Element`에 대해서도 작동할 수 있으면서 타입 안전성을 유지합니다.
* **타입 캐스팅 (Type Casting)**: `Any` 배열에서 요소를 꺼내 사용하거나, 특정 프로토콜을 따르는 객체로 다루고자 할 때 `as?` (조건부 캐스팅) 또는 `as!` (강제 캐스팅)을 사용합니다.

---

## 6. 유용한 배열 프로퍼티 및 메서드 (Useful Array Properties and Methods)

배열은 데이터를 다루는 데 유용한 다양한 내장 프로퍼티와 메서드를 제공합니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **`.count`**: 배열에 포함된 요소의 개수를 반환합니다. (정수)
* **`.isEmpty`**: 배열이 비어있는지 여부를 반환합니다. (`.count == 0` 과 동일하지만 더 가독성이 좋습니다.)
* **`remove(at:)`**, **`removeAll()`**: 위에서 설명.
* **`contains(_:)`**: 배열이 특정 요소를 포함하고 있는지 여부를 `Bool` 값으로 반환합니다. 요소의 타입은 `Equatable` 프로토콜을 준수해야 합니다.
* **`sorted()`**: 배열의 요소를 오름차순으로 정렬한 **새로운 배열**을 반환합니다. 원본 배열은 변경되지 않습니다. 요소의 타입은 `Comparable` 프로토콜을 준수해야 합니다.
    * **사용자 정의 정렬 (`sorted(by:)`)**: 클로저를 사용하여 자신만의 정렬 기준을 제공할 수 있습니다.
* **`reversed()`**: 배열의 요소를 역순으로 하는 **뷰(view)** (`ReversedCollection`)를 반환합니다. 원본 배열은 변경되지 않으며, 실제 요소들을 재배열하지 않고 역순으로 접근할 수 있는 방법을 제공합니다.
    * **`ReversedCollection`을 다시 배열로**: `Array(reversedCollection)`을 사용하여 새로운 배열을 얻을 수 있습니다.
* **고차 함수 (Higher-Order Functions)**: 배열을 다루는 강력한 방법들입니다.
    * **`map(_:)`**: 배열의 각 요소에 주어진 클로저(변환 함수)를 적용하여 새로운 배열을 반환합니다.
    * **`filter(_:)`**: 주어진 클로저(조건 함수)를 만족하는 요소들만으로 구성된 새로운 배열을 반환합니다.
    * **`reduce(_:_:)`**: 배열의 모든 요소를 결합하여 단일 값을 반환합니다. (예: 모든 숫자의 합, 모든 문자열 연결)

### ✨ 구체적인 예시 (Specific Examples)

* **`.isEmpty` 사용**:
    ```swift
    var shoppingList = ["Milk", "Eggs"]
    if !shoppingList.isEmpty {
        print("장 볼 것이 있습니다!")
    }
    shoppingList.removeAll()
    if shoppingList.isEmpty {
        print("장보기 완료!")
    }
    ```
* **`sorted(by:)`로 사용자 정의 정렬**:
    ```swift
    let numbers = [1, 5, 3, 9, 2, 8]
    // 내림차순 정렬
    let descendingNumbers = numbers.sorted(by: >)
    print(descendingNumbers) // [9, 8, 5, 3, 2, 1]

    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    // 문자열 길이로 정렬 (짧은 것부터)
    let sortedByLength = names.sorted { $0.count < $1.count }
    print(sortedByLength) // ["Ewa", "Alex", "Chris", "Barry", "Daniella"]
    ```
* **`Array(reversedCollection)`**:
    ```swift
    let presidents = ["Bush", "Obama", "Trump", "Biden"]
    let reversedPresidentsView = presidents.reversed() // ReversedCollection<[String]> 타입
    let reversedPresidentsArray = Array(reversedPresidentsView) // [String] 타입으로 변환
    print(reversedPresidentsArray) // ["Biden", "Trump", "Obama", "Bush"]
    ```
* **`map`, `filter`, `reduce` 간단한 예시**:
    ```swift
    let values = [1, 2, 3, 4, 5]

    // map: 각 숫자를 제곱
    let squaredValues = values.map { $0 * $0 }
    print(squaredValues) // [1, 4, 9, 16, 25]

    // filter: 짝수만 필터링
    let evenValues = values.filter { $0 % 2 == 0 }
    print(evenValues) // [2, 4]

    // reduce: 모든 숫자의 합
    let sumOfValues = values.reduce(0, +) // 초기값 0, 각 요소를 더함
    print(sumOfValues) // 15
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **클로저 (Closures)**: `sorted(by:)`, `map`, `filter`, `reduce`와 같은 고차 함수는 클로저를 인자로 받아 동작을 정의합니다. 클로저에 대한 이해는 배열을 효과적으로 다루는 데 필수적입니다.
* **프로토콜 (Protocols)**:
    * **`Equatable`**: `contains(_:)` 메서드를 사용하려면 배열의 요소 타입이 `Equatable` 프로토콜을 준수해야 합니다 (값이 같은지 비교 가능해야 함). 대부분의 기본 타입은 이를 준수합니다.
    * **`Comparable`**: `sorted()` 메서드를 사용하려면 요소 타입이 `Comparable` 프로토콜을 준수해야 합니다 (값의 크기 비교가 가능해야 함). `Int`, `String` 등 기본 타입이 이를 준수합니다.
* **시퀀스(Sequence)와 컬렉션(Collection) 프로토콜**: 배열은 이 프로토콜들을 준수하며, 이로 인해 다양한 유용한 기능을 상속받습니다.

---

## 7. 다차원 배열 (Multidimensional Arrays)

배열의 요소가 또 다른 배열인 경우, 이를 다차원 배열이라고 합니다. 가장 흔한 형태는 2차원 배열로, 행렬(matrix)이나 그리드(grid) 형태의 데이터를 표현하는 데 사용됩니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **배열의 배열**: `[[Int]]`는 정수 배열을 요소로 갖는 배열을 의미합니다 (즉, 정수들의 2차원 배열).
* **접근**: `matrix[row][column]` 형태로 각 요소에 접근합니다.
* **가변 크기 행**: 내부 배열들이 반드시 같은 크기일 필요는 없지만, 보통 행렬과 같은 구조에서는 동일한 크기를 갖도록 관리합니다.

### ✨ 구체적인 예시 (Specific Examples)

* **2x3 정수 행렬 생성 및 접근**:
    ```swift
    var numberGrid = [
        [1, 2, 3],
        [4, 5, 6]
    ]
    print(numberGrid[0][0]) // 1 (첫 번째 행, 첫 번째 열)
    print(numberGrid[1][2]) // 6 (두 번째 행, 세 번째 열)

    numberGrid[0].append(0) // 첫 번째 행에 0 추가: [[1, 2, 3, 0], [4, 5, 6]]
    numberGrid.append([7, 8, 9]) // 새 행 추가: [[1, 2, 3, 0], [4, 5, 6], [7, 8, 9]]
    print(numberGrid)
    ```
* **틱택토(Tic-Tac-Toe) 보드 예시 (문자열 배열)**:
    ```swift
    typealias TicTacToeBoard = [[String?]] // nil은 빈 칸을 의미
    var board: TicTacToeBoard = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
    ]

    // X가 (0,0)에 표시
    board[0][0] = "X"

    // O가 (1,1)에 표시
    board[1][1] = "O"

    for row in board {
        print(row.map { $0 ?? "_" }) // nil이면 "_"로 표시
    }
    // ["X", "_", "_"]
    // ["_", "O", "_"]
    // ["_", "_", "_"]
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **중첩 반복문 (Nested Loops)**: 다차원 배열의 모든 요소를 순회하려면 중첩된 `for-in` 루프를 사용합니다.
    ```swift
    for row in numberGrid {
        for number in row {
            print(number, terminator: " ")
        }
        print() // 다음 행으로 줄바꿈
    }
    ```
* **게임 개발, 이미지 처리, 데이터 분석**: 다차원 배열은 그리드 기반 게임(체스, 바둑 등), 픽셀 데이터 처리, 표 형태의 데이터 관리 등 다양한 분야에서 활용됩니다.

---

이 자료가 Swift 배열을 더 깊이 이해하고 활용하는 데 도움이 되기를 바랍니다! 꾸준히 연습하시면 배열을 자유자재로 다룰 수 있게 될 거예요. 화이팅입니다! 💪

# Swift 딕셔너리 깊이 파헤치기 🔑

딕셔너리는 **키(key)와 값(value)의 쌍**으로 이루어진 데이터를 순서 없이 저장하는 컬렉션 타입입니다. 배열이 인덱스(위치)를 사용해 데이터에 접근하는 반면, 딕셔너리는 고유한 키를 사용해 값에 접근합니다. 이는 특정 데이터를 이름표(키)로 찾아야 할 때 매우 유용합니다.

---

## 1. 딕셔너리란 무엇인가? (What are Dictionaries?)

제공해주신 설명처럼, 배열은 순서가 중요하거나 중복 항목이 있을 때 좋지만, 위치로 데이터에 접근하는 것은 혼란을 야기하거나 위험할 수 있습니다. `employee[2]`가 무엇을 의미하는지, 또는 해당 위치에 값이 존재할지 확신하기 어렵기 때문입니다. 딕셔너리는 이러한 문제를 해결합니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **순서가 없는 컬렉션 (Unordered Collection)**: 딕셔너리에 저장된 항목들은 특정 순서를 따르지 않습니다. 항목을 추가한 순서대로 유지되지 않으며, 조회할 때마다 순서가 다를 수 있습니다. (Swift 3.0 이후 버전에서는 내부적으로 순서가 어느 정도 예측 가능하게 되었지만, 여전히 '순서가 없다'고 가정하고 사용하는 것이 안전합니다.)
* **키-값 쌍 (Key-Value Pairs)**: 각 항목은 고유한 **키**와 그에 대응하는 **값**으로 구성됩니다. 예를 들어, `"name": "Taylor Swift"`에서 `"name"`은 키, `"Taylor Swift"`는 값입니다.
* **키의 유일성 (Uniqueness of Keys)**: 딕셔너리 내의 모든 키는 **유일해야 합니다**. 동일한 키로 값을 여러 번 추가하려고 하면, 마지막에 추가된 값으로 덮어쓰여집니다. (이는 값을 업데이트하는 방법이기도 합니다.)
* **값 타입 (Value Type)**: 배열과 마찬가지로 Swift의 딕셔너리도 값 타입입니다. 딕셔너리를 다른 변수에 할당하거나 함수에 전달하면 복사본이 생성되어 전달됩니다.
* **키의 타입 제약 (`Hashable`)**: 딕셔너리의 키로 사용될 수 있는 타입은 반드시 **`Hashable` 프로토콜**을 준수해야 합니다. `Hashable`은 각 값에 대해 정수 해시 값을 제공할 수 있음을 의미하며, 이는 딕셔너리가 키를 효율적으로 검색하고 저장하는 데 필요합니다. Swift의 기본 타입인 `String`, `Int`, `Double`, `Bool` 등은 모두 `Hashable`을 준수합니다. 사용자 정의 타입을 키로 사용하려면 `Hashable` 프로토콜을 채택해야 합니다. 값(value)의 타입에는 이러한 제약이 없습니다.

### ✨ 구체적인 예시 (Specific Examples)

* **다양한 키/값 타입의 딕셔너리**:
    * `Int` 키, `String` 값 (제공된 `olympics` 예시와 유사):
        ```swift
        let productCodes: [Int: String] = [
            404: "Not Found Error",
            200: "OK Status",
            500: "Internal Server Error"
        ]
        print(productCodes[200, default: "Unknown Code"]) // "OK Status"
        ```
    * `String` 키, `Double` 값:
        ```swift
        var stockPrices: [String: Double] = [
            "AAPL": 170.34,
            "GOOG": 2800.75,
            "MSFT": 300.50
        ]
        stockPrices["AAPL"] = 172.50 // 값 업데이트
        print(stockPrices)
        ```
    * `Character` 키, `String` 값:
        ```swift
        let gradeMeanings: [Character: String] = [
            "A": "Excellent",
            "B": "Good",
            "C": "Average",
            "F": "Fail"
        ]
        ```
* **딕셔너리 값으로 배열 또는 다른 딕셔너리 사용**:
    ```swift
    // 값으로 배열 사용
    var playlists: [String: [String]] = [
        "Chill Mix": ["Song A", "Song B", "Song C"],
        "Workout Hits": ["Track 1", "Track 2", "Track 3"]
    ]
    print(playlists["Chill Mix", default: []]) // ["Song A", "Song B", "Song C"]

    // 값으로 다른 딕셔너리 사용
    var userPreferences: [String: [String: String]] = [
        "user123": ["theme": "dark", "language": "en"],
        "user456": ["theme": "light", "language": "ko"]
    ]
    print(userPreferences["user123", default: [:]]["theme", default: "default_theme"]) // "dark"
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **배열 (Arrays) vs 딕셔너리 (Dictionaries)**: 데이터의 순서가 중요한지, 중복이 허용되는지, 데이터 접근 방식(인덱스 vs 키)에 따라 적절한 컬렉션을 선택합니다.
* **`Hashable` 프로토콜**: 사용자 정의 타입을 딕셔너리 키로 사용하기 위해 필수적으로 이해해야 합니다.
* **JSON (JavaScript Object Notation) 데이터와 딕셔너리**: JSON은 웹에서 데이터를 주고받을 때 널리 사용되는 형식으로, Swift의 딕셔너리 구조와 매우 유사하여 상호 변환이 쉽습니다. (주로 `[String: Any]` 형태로 다룸)

---

## 2. 딕셔너리 생성 및 초기화 (Creating and Initializing Dictionaries)

딕셔너리는 리터럴을 사용하거나, 명시적인 타입 선언과 함께 빈 딕셔너리로 생성할 수 있습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **리터럴을 사용한 생성**: `[키1: 값1, 키2: 값2, ...]` 형태로 대괄호 안에 키-값 쌍을 나열합니다.
    ```swift
    let capitals = ["South Korea": "Seoul", "Japan": "Tokyo", "USA": "Washington D.C."]
    ```
* **빈 딕셔너리 생성**:
    * `var emptyDict = [KeyType: ValueType]()` (예: `var userScores = [String: Int]()`)
    * `var anotherEmptyDict: [KeyType: ValueType] = [:]` (예: `var settings: [String: Bool] = [:]`)
* **`Dictionary(uniqueKeysWithValues:)`**: (키, 값) 튜플의 시퀀스(예: 배열)로부터 딕셔너리를 생성합니다. 이 방법은 키가 유일하다고 확신할 때 사용합니다.
    ```swift
    let countryCodes = [("KR", "South Korea"), ("US", "United States"), ("JP", "Japan")]
    let countryDictionary = Dictionary(uniqueKeysWithValues: countryCodes)
    // countryDictionary는 ["KR": "South Korea", "US": "United States", "JP": "Japan"]
    print(countryDictionary)
    ```
* **`Dictionary(grouping:by:)`**: 시퀀스의 요소들을 그룹화하여 딕셔너리를 생성할 때 유용합니다. (심화)

### ✨ 구체적인 예시 (Specific Examples)

* **`Dictionary(uniqueKeysWithValues:)` 사용 예시**:
    ```swift
    let productIDs = [101, 102, 103]
    let productNames = ["Laptop", "Mouse", "Keyboard"]
    // zip 함수를 사용하여 두 배열을 (ID, Name) 튜플의 시퀀스로 만듦
    let products = Dictionary(uniqueKeysWithValues: zip(productIDs, productNames))
    // products는 [101: "Laptop", 102: "Mouse", 103: "Keyboard"] (순서는 다를 수 있음)
    print(products)
    ```
* **딕셔너리 리터럴의 가독성 있는 표현**:
    ```swift
    let bookDetails = [
        "title": "The Little Prince",
        "author": "Antoine de Saint-Exupéry",
        "yearPublished": 1943,
        "genre": "Novella"
    ] // 가독성을 위해 여러 줄로 작성 가능
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **타입 추론 (Type Inference)**: Swift는 딕셔너리 리터럴로부터 키와 값의 타입을 자동으로 유추합니다.
* **생성자 (Initializers)**: `[KeyType: ValueType]()`나 `Dictionary(uniqueKeysWithValues:)`는 딕셔너리 타입의 다양한 생성자 중 일부입니다.
* **`zip` 함수**: 두 시퀀스를 페어로 묶어 새로운 시퀀스를 만드는 데 유용합니다.

---

## 3. 딕셔너리 값 접근 및 수정 (Accessing and Modifying Dictionary Values)

딕셔너리의 값은 해당 키를 사용하여 접근, 수정, 추가 또는 삭제할 수 있습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **키를 사용한 값 접근**: `dictionary[key]` 구문을 사용합니다.
    * **반환 타입은 옵셔널 (`Value?`)**: 요청한 키가 딕셔너리에 존재하지 않을 수 있기 때문에, 값은 항상 옵셔널 타입으로 반환됩니다. 즉, 실제 값이 있거나 `nil`일 수 있습니다.
    * Xcode에서 `Expression implicitly coerced from 'String?' to 'Any’` 와 같은 경고는 이 옵셔널 특성 때문에 발생합니다. `print()` 함수는 `Any` 타입의 인자를 받는데, 옵셔널 `String?`이 암시적으로 `Any`로 변환되면서 "이 데이터가 없을 수도 있는데 괜찮은가?"라는 의미를 내포하는 것입니다.
* **옵셔널 처리 방법**:
    * **기본값 제공 (Default Value)**: `dictionary[key, default: defaultValue]`를 사용하면 키가 없을 경우 `defaultValue`를 반환합니다. (옵셔널이 아닌 실제 `Value` 타입 반환)
        ```swift
        print(employee2["password", default: "N/A"]) // 키가 없으므로 "N/A" 출력
        ```
    * **옵셔널 바인딩 (Optional Binding)**: `if let` 구문을 사용하여 안전하게 값을 추출합니다.
        ```swift
        if let jobTitle = employee2["job"] {
            print("Job: \(jobTitle)") // jobTitle은 옵셔널이 해제된 String 타입
        } else {
            print("Job title not found.")
        }
        ```
    * 강제 언래핑 (`!`) (주의해서 사용): 키가 반드시 존재한다고 확신할 때만 사용합니다. 키가 없으면 런타임 오류가 발생합니다.
* **값 추가 및 수정**:
    * `dictionary[key] = newValue` 구문을 사용합니다.
    * `key`가 딕셔너리에 **없으면** 새로운 키-값 쌍이 추가됩니다.
    * `key`가 딕셔너리에 **이미 있으면** 해당 키의 값이 `newValue`로 업데이트(덮어쓰기)됩니다.
* **`updateValue(_:forKey:)` 메서드**: 값을 추가하거나 수정할 때 사용하며, **업데이트 전의 이전 값(옵셔널)**을 반환합니다. 키가 존재하지 않았다면 `nil`을 반환하고 새 값을 설정합니다.
    ```swift
    var ages = ["Alice": 30, "Bob": 25]
    if let oldAge = ages.updateValue(31, forKey: "Alice") {
        print("Alice's old age was \(oldAge)") // "Alice's old age was 30"
    }
    print(ages["Alice", default: 0]) // 31
    ```
* **값 삭제**:
    * **`removeValue(forKey:)`**: 지정된 키에 해당하는 값을 삭제하고, 삭제된 값(옵셔널)을 반환합니다. 키가 없으면 `nil`을 반환합니다.
    * **키에 `nil` 할당**: `dictionary[key] = nil`과 같이 특정 키에 `nil`을 할당하여 해당 키-값 쌍을 삭제할 수 있습니다.

### ✨ 구체적인 예시 (Specific Examples)

* **옵셔널 바인딩으로 안전하게 값 접근**:
    ```swift
    let studentScores = ["Math": 90, "Science": 85]
    if let mathScore = studentScores["Math"] {
        print("Math score: \(mathScore)")
    } else {
        print("Math score not available.")
    }

    if let historyScore = studentScores["History"] { // "History" 키는 없음
        print("History score: \(historyScore)")
    } else {
        print("History score not available.") // 이 부분이 실행됨
    }
    ```
* **`updateValue(_:forKey:)` 사용**:
    ```swift
    var config = ["darkMode": true, "fontSize": 14]
    // fontSize 업데이트
    if let previousFontSize = config.updateValue(16, forKey: "fontSize") {
        print("Previous font size was: \(previousFontSize)") // "Previous font size was: 14"
    }
    // 새로운 키-값 추가
    if let previousNotifications = config.updateValue(true, forKey: "notificationsEnabled") {
        // 이 블록은 실행되지 않음, notificationsEnabled는 새 키이므로 이전 값은 nil
    } else {
        print("notificationsEnabled was newly set.")
    }
    print(config) // ["darkMode": true, "fontSize": 16, "notificationsEnabled": true] (순서는 다를 수 있음)
    ```
* **`removeValue(forKey:)` 및 `nil` 할당으로 삭제**:
    ```swift
    var fruits = ["apple": 5, "banana": 10, "orange": 7]
    // removeValue(forKey:)
    if let removedApples = fruits.removeValue(forKey: "apple") {
        print("\(removedApples) apples removed.") // "5 apples removed."
    }
    print(fruits) // ["banana": 10, "orange": 7] (순서는 다를 수 있음)

    // nil 할당
    fruits["banana"] = nil
    print(fruits) // ["orange": 7] (순서는 다를 수 있음)
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **옵셔널 (Optionals)**: 딕셔너리 값 접근 시 핵심 개념이므로 반드시 숙지해야 합니다. (옵셔널 체이닝, nil-병합 연산자 `??` 등)
* **Subscripting (서브스크립트)**: `dictionary[key]`와 같이 대괄호를 사용하여 컬렉션의 요소에 접근하는 문법을 서브스크립트라고 합니다. 딕셔너리뿐만 아니라 배열, 사용자 정의 타입에서도 서브스크립트를 정의할 수 있습니다.

---

## 4. 딕셔너리 반복 및 주요 프로퍼티/메서드 (Iterating and Key Properties/Methods)

딕셔너리는 저장된 모든 항목을 순회하거나, 키 또는 값들만 따로 얻어오는 기능을 제공합니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **`for-in` 루프를 사용한 순회**: 딕셔너리의 각 키-값 쌍을 (키, 값) 튜플 형태로 가져와 순회합니다.
    ```swift
    for (key, value) in dictionary {
        print("\(key): \(value)")
    }
    ```
* **`.keys` 프로퍼티**: 딕셔너리의 모든 **키**들을 포함하는 컬렉션(정확히는 `Dictionary.Keys` 타입)을 반환합니다. 이 컬렉션은 배열처럼 사용할 수 있습니다.
* **`.values` 프로퍼티**: 딕셔너리의 모든 **값**들을 포함하는 컬렉션(`Dictionary.Values` 타입)을 반환합니다.
* **`.count`**: 딕셔너리에 있는 키-값 쌍의 개수를 반환합니다.
* **`.isEmpty`**: 딕셔너리가 비어있는지 여부를 `Bool` 값으로 반환합니다. (`.count == 0` 과 동일)
* **`removeAll()`**: 딕셔너리의 모든 키-값 쌍을 제거합니다. 선택적으로 `keepingCapacity` 매개변수를 사용하여 내부 저장 공간을 유지할지 결정할 수 있습니다.

### ✨ 구체적인 예시 (Specific Examples)

* **`for (key, value) in dictionary` 사용**:
    ```swift
    let cityPopulations = ["Seoul": 9_700_000, "New York": 8_400_000, "Tokyo": 13_900_000]
    for (city, population) in cityPopulations {
        print("\(city) has a population of \(population).")
    }
    // 출력 순서는 보장되지 않음
    ```
* **`.keys`와 `.values` 사용**:
    ```swift
    let contacts = ["John": "123-4567", "Jane": "987-6543", "Mike": "555-0000"]

    // 모든 키 출력
    for name in contacts.keys {
        print(name) // John, Jane, Mike (순서 보장 안됨)
    }

    // 모든 값 출력
    for phoneNumber in contacts.values {
        print(phoneNumber) // 123-4567, 987-6543, 555-0000 (순서 보장 안됨)
    }

    // 키 컬렉션을 배열로 변환하여 정렬
    let sortedNames = contacts.keys.sorted()
    print(sortedNames) // ["Jane", "John", "Mike"] (알파벳 순)
    ```
* **`.isEmpty` 사용**:
    ```swift
    var tasks: [String: String] = [:]
    if tasks.isEmpty {
        print("No tasks to do!")
    }
    tasks["morning"] = "Meeting"
    if !tasks.isEmpty {
        print("You have tasks.")
    }
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **튜플 (Tuples)**: `for-in` 루프로 딕셔너리를 순회할 때 각 항목은 `(key, value)` 형태의 튜플로 반환됩니다.
* **컬렉션 프로토콜 (Collection Protocols)**: `Dictionary.Keys`와 `Dictionary.Values`는 `Collection` 프로토콜을 준수하므로, `count`, `isEmpty`, `sorted()` 등 다양한 컬렉션 관련 기능을 사용할 수 있습니다.

---

## 5. 딕셔너리와 타입 안전성 (Dictionaries and Type Safety)

Swift의 딕셔너리는 타입에 안전합니다. 한번 정의된 키와 값의 타입은 변경될 수 없으며, 해당 타입의 데이터만 저장할 수 있습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **키와 값의 타입 고정**: `[String: Int]`로 선언된 딕셔너리는 문자열 키와 정수 값만 가질 수 있습니다. 다른 타입의 키나 값을 추가하려고 하면 컴파일 오류가 발생합니다.
* **`[AnyHashable: Any]`**: 다양한 타입의 키와 값을 하나의 딕셔너리에 저장해야 할 때 사용할 수 있습니다.
    * **키**: `AnyHashable`은 모든 `Hashable` 타입을 감싸는 타입입니다. `String`, `Int` 등 기본 `Hashable` 타입은 자동으로 `AnyHashable`로 변환될 수 있습니다.
    * **값**: `Any`는 모든 타입의 값을 나타낼 수 있습니다.
    * **주의점**: `[AnyHashable: Any]`를 사용하면 타입 안전성의 일부 이점을 잃게 됩니다. 값을 꺼내 사용할 때 어떤 타입인지 알 수 없으므로, 타입 캐스팅(`as?`, `as!`)이 필요하며, 이는 런타임 오류의 가능성을 높입니다. 가급적 구체적인 타입을 사용하는 것이 좋습니다.

### ✨ 구체적인 예시 (Specific Examples)

* **`[AnyHashable: Any]` 딕셔너리 사용 및 타입 캐스팅**:
    ```swift
    var mixedData: [AnyHashable: Any] = [
        "name": "Alex",
        42: "The Answer",
        "isValid": true,
        "dimensions": [20.5, 10.0]
    ]

    if let name = mixedData["name"] as? String {
        print("Name: \(name)") // "Name: Alex"
    }

    if let answer = mixedData[42] as? String {
        print("Answer for 42: \(answer)") // "Answer for 42: The Answer"
    }

    if let isValid = mixedData["isValid"] as? Bool {
        print("Is valid: \(isValid)") // "Is valid: true"
    }

    if let dimensions = mixedData["dimensions"] as? [Double] {
        print("First dimension: \(dimensions[0])") // "First dimension: 20.5"
    }
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **`AnyHashable` 타입**: 다양한 `Hashable` 타입을 하나의 컬렉션(주로 딕셔너리 키)에 담기 위해 사용됩니다.
* **타입 캐스팅 (Type Casting)**: `Any` 또는 `AnyHashable`로 저장된 값을 원래의 구체적인 타입으로 사용하기 위해 `as?` (옵셔널 캐스팅) 또는 `as!` (강제 캐스팅)을 사용합니다.

---

딕셔너리는 데이터를 유연하고 의미 있게 관리하는 데 매우 강력한 도구입니다. 키를 통해 데이터에 접근하는 방식과 옵셔널의 개념을 잘 이해하고 활용하는 것이 중요합니다. 즐거운 코딩 되세요! 🎉

# Swift Set 정복하기 🛡️

Set은 **순서가 없고, 중복된 항목을 허용하지 않는** 값들의 컬렉션입니다. 배열과 유사하지만, 고유한 값들만 저장하고 싶거나 항목의 저장 순서가 중요하지 않을 때, 그리고 특정 항목의 포함 여부를 매우 빠르게 확인하고 싶을 때 유용합니다.

---

## 1. Set이란 무엇인가? (What are Sets?)

배열, 딕셔너리와 함께 Swift의 기본적인 컬렉션 타입 중 하나입니다. Set은 다음과 같은 주요 특징을 가집니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **순서가 없는 컬렉션 (Unordered Collection)**: Set에 저장된 항목들은 특정 순서를 따르지 않습니다. 항목을 추가한 순서대로 유지되지 않으며, Set을 출력하거나 순회할 때마다 순서가 다를 수 있습니다.
* **중복 없는 유일한 요소 (Unique Elements)**: Set은 동일한 값을 두 번 이상 저장할 수 없습니다. 이미 Set에 있는 값을 다시 추가하려고 하면, 해당 값은 한 번만 유지됩니다.
* **값 타입 (Value Type)**: 배열, 딕셔너리와 마찬가지로 Swift의 Set도 값 타입입니다. Set을 다른 변수에 할당하거나 함수에 전달하면 복사본이 생성되어 전달됩니다.
* **요소의 타입 제약 (`Hashable`)**: Set에 저장될 수 있는 타입은 반드시 **`Hashable` 프로토콜**을 준수해야 합니다. `Hashable`은 각 값에 대해 정수 해시 값을 제공할 수 있음을 의미하며, 이는 Set이 요소를 효율적으로 저장하고 검색(특히 `contains()` 메서드 사용 시)하는 데 필수적입니다. Swift의 기본 타입(`String`, `Int`, `Double`, `Bool` 등)은 모두 `Hashable`을 준수합니다.

### ✨ 구체적인 예시 (Specific Examples)

* **다양한 `Hashable` 타입의 Set**:
    * 정수(Int) Set:
        ```swift
        let winningNumbers = Set([3, 15, 22, 37, 40, 42])
        let myNumbers = Set([10, 22, 25, 37, 41])
        print(winningNumbers) // 순서는 보장되지 않음
        ```
    * 문자(Character) Set:
        ```swift
        var vowels = Set<Character>()
        vowels.insert("a")
        vowels.insert("e")
        vowels.insert("i")
        vowels.insert("o")
        vowels.insert("u")
        print(vowels) // ["e", "o", "i", "u", "a"] (예시, 순서는 다를 수 있음)
        ```
* **Set을 사용한 고유값 필터링**: 배열에서 중복을 제거하고 고유한 값만 얻고 싶을 때 Set을 활용할 수 있습니다.
    ```swift
    let duplicateValues = [1, 2, 2, 3, 4, 4, 4, 5]
    let uniqueValues = Set(duplicateValues)
    print(uniqueValues) // [5, 2, 3, 1, 4] (예시, 순서는 다를 수 있음)
    // 필요하다면 다시 정렬된 배열로 변환
    let sortedUniqueValues = Array(uniqueValues).sorted()
    print(sortedUniqueValues) // [1, 2, 3, 4, 5]
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **배열 (Arrays) vs 딕셔너리 (Dictionaries) vs Set (Sets) 비교**:
    * **배열**: 순서 O, 중복 O. 인덱스 기반 접근.
    * **딕셔너리**: 순서 X (대체로), 키-값 쌍, 키 중복 X. 키 기반 접근. 키는 `Hashable`.
    * **Set**: 순서 X, 중복 X. 요소는 `Hashable`. 빠른 포함 여부 확인.
* **`Hashable` 프로토콜**: Set 요소 타입의 필수 조건이므로 이해가 중요합니다.
* **언제 Set을 사용해야 하는가? (Use Cases)**:
    * 항목의 고유성이 중요할 때 (예: 사용자 ID, 이메일 주소 목록).
    * 항목의 존재 여부를 빠르게 확인해야 할 때 (예: 금지된 단어 목록 확인).
    * 데이터 간의 집합 연산(교집합, 합집합 등)이 필요할 때.

---

## 2. Set 생성 및 요소 추가 (Creating Sets and Inserting Elements)

Set은 배열 리터럴로부터 생성하거나, 빈 Set으로 시작하여 요소를 하나씩 추가할 수 있습니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **배열 리터럴로부터 생성**: `Set([요소1, 요소2, ...])` 형태로, 배열을 먼저 만든 후 그 배열을 Set으로 변환합니다. 이 과정에서 중복된 요소는 자동으로 제거됩니다.
    ```swift
    let ingredients = Set(["flour", "sugar", "eggs", "sugar"]) // "sugar"는 하나만 저장됨
    print(ingredients) // ["eggs", "flour", "sugar"] (예시, 순서는 다를 수 있음)
    ```
* **빈 Set 생성**: `var mySet = Set<ElementType>()` 형태로 타입을 명시하여 빈 Set을 만듭니다.
    ```swift
    var attendees = Set<String>()
    ```
* **`insert(_:)` 메서드**: Set에 새로운 요소를 추가합니다.
    * 배열의 `append()`와 달리, `insert()`는 Set의 "끝"에 추가하는 개념이 아닙니다 (순서가 없으므로).
    * **반환 값**: `insert(_:)` 메서드는 튜플 `(inserted: Bool, memberAfterInsert: Element)`을 반환합니다.
        * `inserted`: 새로운 요소가 실제로 추가되었으면 `true`, 이미 요소가 존재하여 추가되지 않았으면 `false`입니다.
        * `memberAfterInsert`: Set에 저장된 (또는 이미 존재하던) 요소를 반환합니다.

### ✨ 구체적인 예시 (Specific Examples)

* **`insert` 메서드의 반환값 활용**:
    ```swift
    var favoriteColors = Set<String>()
    let (insertedBlue, memberBlue) = favoriteColors.insert("blue")
    print("Blue inserted: \(insertedBlue), Member: \(memberBlue)") // Blue inserted: true, Member: blue

    let (insertedRed, memberRed) = favoriteColors.insert("red")
    print("Red inserted: \(insertedRed), Member: \(memberRed)")   // Red inserted: true, Member: red

    let (insertedBlueAgain, memberBlueAgain) = favoriteColors.insert("blue") // 이미 "blue"가 있음
    print("Blue inserted again: \(insertedBlueAgain), Member: \(memberBlueAgain)") // Blue inserted again: false, Member: blue
    print(favoriteColors) // ["red", "blue"] (예시, 순서는 다를 수 있음)
    ```
* **정수 Set 생성 및 요소 추가**:
    ```swift
    var primesUpTo10 = Set<Int>()
    primesUpTo10.insert(2)
    primesUpTo10.insert(3)
    primesUpTo10.insert(5)
    primesUpTo10.insert(7)
    primesUpTo10.insert(5) // 중복, 추가되지 않음
    print(primesUpTo10) // [5, 2, 7, 3] (예시, 순서는 다를 수 있음)
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **타입 추론 (Type Inference)**: `let numbers = Set([1, 2, 3])` 처럼 Swift는 배열 리터럴로부터 Set의 요소 타입을 추론할 수 있습니다.
* **생성자 (Initializers)**: `Set<ElementType>()` 또는 `Set(someSequence)`는 Set 타입의 생성자를 호출하는 예입니다.

---

## 3. Set의 특징과 장점 (Characteristics and Advantages of Sets)

Set의 고유한 특징들은 특정 상황에서 큰 장점으로 작용합니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **중복 불허**: 앞서 설명한 것처럼, 이는 데이터의 유일성을 보장해야 할 때 유용합니다 (예: 설문조사에서 중복 응답자 제거, 태그 목록 관리).
* **순서 없음**: 순서가 중요하지 않은 데이터를 다룰 때 메모리나 처리 과정에서 순서 유지에 드는 비용을 절약할 수 있습니다.
* **빠른 검색 (`contains()`)**: Set의 가장 큰 장점 중 하나입니다. Set은 내부적으로 **해시 테이블(Hash Table)**과 유사한 구조를 사용하여 요소를 저장합니다. 이 덕분에 특정 요소가 Set에 포함되어 있는지 확인하는 `contains()` 연산이 매우 빠릅니다. 요소의 수에 거의 관계없이 거의 일정한 시간 안에 결과를 얻을 수 있습니다.
    * 배열에서 `contains()`를 사용하면 최악의 경우 모든 요소를 하나씩 비교해야 합니다 (선형 검색). 요소가 많을수록 느려집니다.
    * Set은 요소의 해시 값을 사용하여 저장 위치를 결정하므로, 검색 시에도 해시 값을 통해 빠르게 접근할 수 있습니다.

### ✨ 구체적인 예시 (Specific Examples)

* **`contains()` 성능**:
    * 10,000개의 영화 제목이 담긴 **배열**에서 특정 영화를 찾는 것은 수천 번의 비교가 필요할 수 있습니다.
    * 10,000개의 영화 제목이 담긴 **Set**에서 특정 영화를 찾는 것은 거의 즉시 이루어집니다. 심지어 1,000,000개의 요소가 있어도 Set에서의 검색은 매우 빠릅니다.
* **태그(tag) 관리 시스템 예시**:
    ```swift
    var articleTags = Set<String>()
    articleTags.insert("swift")
    articleTags.insert("ios")
    articleTags.insert("programming")

    // 사용자가 새 태그 "swift"를 추가하려 할 때 (이미 존재함)
    articleTags.insert("swift") // 변화 없음, 중복 허용 안 함

    // 특정 태그가 있는지 빠르게 확인
    if articleTags.contains("ios") {
        print("This article is tagged with iOS.")
    }
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **해시 테이블 (Hash Tables)**: Set과 딕셔너리가 빠른 검색 성능을 가질 수 있게 하는 핵심 자료 구조입니다. `Hashable` 프로토콜과 밀접하게 관련됩니다.
* **시간 복잡도 (Big O Notation)**: Set에서 `insert()`, `remove()`, `contains()` 연산의 평균 시간 복잡도는 O(1) (상수 시간)입니다. 배열의 경우 `contains()`는 O(n) (선형 시간)입니다.

---

## 4. Set의 기본 연산 (Basic Set Operations)

Set은 요소의 개수를 세거나, 특정 요소를 확인/삭제하고, 전체를 비우는 등의 기본적인 연산을 지원합니다.

### 📝 추가 개념 설명 (Additional Concepts)

* **`count`**: Set에 포함된 요소의 개수를 반환합니다. (정수)
* **`isEmpty`**: Set이 비어있는지 여부를 `Bool` 값으로 반환합니다. (`.count == 0` 과 동일)
* **`contains(_:)`**: Set이 특정 요소를 포함하고 있는지 여부를 `Bool` 값으로 반환합니다. (매우 빠름)
* **`remove(_:)`**: Set에서 특정 요소를 삭제합니다. 만약 요소가 Set에 있었다면 해당 요소를 반환하고, 없었다면 `nil`을 반환합니다.
* **`removeAll()`**: Set의 모든 요소를 삭제합니다.
* **`sorted()`**: Set의 요소들을 오름차순으로 정렬한 **새로운 배열**을 반환합니다. Set 자체는 순서가 없으므로, 정렬된 결과를 원할 때 사용합니다. (요소 타입은 `Comparable` 프로토콜을 준수해야 함)

### ✨ 구체적인 예시 (Specific Examples)

* **`remove(_:)` 사용 예시**:
    ```swift
    var techSkills = Set(["Swift", "Python", "Java", "JavaScript"])
    print(techSkills.count) // 4

    if let removedSkill = techSkills.remove("Java") {
        print("\(removedSkill) skill removed.") // "Java skill removed."
    } else {
        print("Skill not found.")
    }
    print(techSkills.count) // 3
    print(techSkills.remove("C++")) // nil (C++는 없었으므로)
    ```
* **`isEmpty` 사용 예시**:
    ```swift
    var shoppingList = Set<String>()
    if shoppingList.isEmpty {
        print("Shopping list is empty.")
    }
    shoppingList.insert("Milk")
    if !shoppingList.isEmpty {
        print("There are items in the shopping list.")
    }
    ```
* **`sorted()` 사용 예시**:
    ```swift
    let unorderedNumbers = Set([5, 1, 10, 3, 8])
    let sortedNumbersArray = unorderedNumbers.sorted() // 배열 [1, 3, 5, 8, 10] 반환
    print(sortedNumbersArray)

    // 내림차순으로 정렬된 배열 얻기
    let reverseSortedNumbers = unorderedNumbers.sorted(by: >)
    print(reverseSortedNumbers) // [10, 8, 5, 3, 1]
    ```

### 🔗 연관 학습 내용 (Related Learning)

* **컬렉션 프로토콜 (Collection Protocols)**: Set은 Swift의 `Collection` 프로토콜 등을 준수하므로, 다양한 컬렉션 관련 공통 기능을 사용할 수 있습니다.

---

## 5. Set의 집합 연산 (Set Operations for Combining and Comparing Sets)

Set은 수학의 집합 이론에서 비롯된 강력한 연산들을 제공하여, 여러 Set 간의 관계를 파악하거나 새로운 Set을 만드는 데 매우 유용합니다.

### 📝 추가 개념 설명 (Additional Concepts)

두 개의 Set `a`와 `b`가 있다고 가정합니다.

* **교집합 (Intersection)**: `a.intersection(b)`
    * 두 Set **모두에** 존재하는 요소들로 이루어진 새로운 Set을 반환합니다. (A ∩ B)
* **합집합 (Union)**: `a.union(b)`
    * 두 Set 중 **하나라도** 포함된 모든 요소들로 이루어진 새로운 Set을 반환합니다. (중복은 자동으로 제거됨) (A ∪ B)
* **차집합 (Subtracting)**: `a.subtracting(b)`
    * Set `a`에는 있지만 Set `b`에는 **없는** 요소들로 이루어진 새로운 Set을 반환합니다. (A - B)
* **대칭차집합 (Symmetric Difference)**: `a.symmetricDifference(b)`
    * 두 Set 중 **한 곳에만** 존재하는 요소들로 이루어진 새로운 Set을 반환합니다. (합집합에서 교집합을 뺀 것과 같음) (A Δ B 또는 (A ∪ B) - (A ∩ B))

* **부분집합 및 상위집합 관계 (Subset and Superset Relationships)**:
    * `a.isSubset(of: b)`: Set `a`의 모든 요소가 Set `b`에 포함되면 `true` (A ⊆ B)
    * `a.isSuperset(of: b)`: Set `a`가 Set `b`의 모든 요소를 포함하면 `true` (A ⊇ B)
    * `a.isStrictSubset(of: b)`: `a`가 `b`의 부분집합이면서, `a`와 `b`가 같지 않으면 `true` (진부분집합, A ⊂ B)
    * `a.isStrictSuperset(of: b)`: `a`가 `b`의 상위집합이면서, `a`와 `b`가 같지 않으면 `true` (진상위집합, A ⊃ B)
    * `a.isDisjoint(with: b)`: 두 Set이 공통된 요소를 전혀 갖지 않으면 `true` (서로소, A ∩ B = ∅)

### ✨ 구체적인 예시 (Specific Examples)

학생들이 수강하는 과목 Set을 예로 들어보겠습니다.

``` swift
let mathStudents = Set(["Alice", "Bob", "Charlie", "David"])
let scienceStudents = Set(["Bob", "Eve", "Charlie", "Frank"])
let artStudents = Set(["Alice", "Eve", "Grace"])

// 교집합: 수학과 과학을 모두 듣는 학생
let mathAndScience = mathStudents.intersection(scienceStudents)
print("Math & Science: \(mathAndScience.sorted())") // ["Bob", "Charlie"]

// 합집합: 수학 또는 과학을 듣는 학생 (또는 둘 다)
let mathOrScience = mathStudents.union(scienceStudents)
print("Math or Science: \(mathOrScience.sorted())") // ["Alice", "Bob", "Charlie", "David", "Eve", "Frank"]

// 차집합: 수학은 듣지만 과학은 듣지 않는 학생
let mathOnly = mathStudents.subtracting(scienceStudents)
print("Math only: \(mathOnly.sorted())") // ["Alice", "David"]

// 대칭차집합: 수학만 듣거나 과학만 듣는 학생
let mathOrScienceNotBoth = mathStudents.symmetricDifference(scienceStudents)
print("Math or Science (not both): \(mathOrScienceNotBoth.sorted())") // ["Alice", "David", "Eve", "Frank"]

// 부분집합 확인
let smallGroup = Set(["Alice", "Bob"])
print("Is smallGroup a subset of mathStudents? \(smallGroup.isSubset(of: mathStudents))") // true

// 서로소 확인
print("Are mathStudents and artStudents disjoint? \(mathStudents.isDisjoint(with: artStudents))") // false (Alice 공통)

let historyStudents = Set(["Zoe", "Liam"])
print("Are mathStudents and historyStudents disjoint? \(mathStudents.isDisjoint(with: historyStudents))") // true


### 🔗 연관 학습 내용 (Related Learning)

- **수학에서의 집합 이론**: Set 연산은 수학적 집합 개념에 기반하므로, 기본 지식이 있다면 이해하기 쉽습니다.
- **논리 연산 (Logical Operations)**: 집합 연산은 논리 연산자 AND (`&&`), OR (`||`), XOR 등과 유사한 개념을 가집니다.

---

Set은 데이터의 고유성을 보장하고, 빠른 검색이 필요하며, 집합 간의 관계를 다뤄야 할 때 매우 강력한 도구입니다. 특히 집합 연산은 복잡한 데이터 필터링 및 조합 로직을 간결하게 표현할 수 있게 해줍니다. 잘 활용해보세요! 👍
```

# 🚀 Swift 열거형(Enum) 심층 학습

제공해주신 내용을 바탕으로 Swift의 열거형(Enum)에 대한 추가적인 개념, 구체적인 예시, 그리고 연관된 학습 내용을 명확하고 구분하기 쉽게 Obsidian 마크다운 형식으로 정리해 드리겠습니다.

---

### 1. 열거형(Enum) 기본 개념 복습 및 심화 🧐

제공된 설명에서 언급된 것처럼, 열거형은 **관련된 값들의 그룹을 위한 공통 타입을 정의**하는 방법입니다. 문자열이나 숫자와 같은 원시 값을 사용하는 것보다 다음과 같은 명확한 이점을 제공합니다.

- **타입 안전성 (Type Safety)**: 정의된 케이스 외의 값을 할당하려는 시도를 컴파일 시점에 막아줍니다. (예: `Weekday.monday`는 가능하지만, `Weekday.january`는 불가능)
- **가독성 (Readability)**: 코드의 의도를 명확하게 표현합니다. `selected = .monday`는 `selected = 0` (월요일을 0으로 가정했을 때) 보다 훨씬 이해하기 쉽습니다.
- **효율성 (Efficiency)**: Swift는 열거형을 내부적으로 최적화된 방식으로 저장합니다 (종종 정수로). 이는 문자열 "Monday"를 저장하는 것보다 메모리 및 성능 면에서 효율적입니다.

```Swift
// 기본 열거형 정의
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

// 단축 구문
enum Weekend {
    case saturday, sunday
}

var today = Weekday.friday
print("Today is \(today).") // 출력: Today is friday.

// 타입 추론을 통한 단축 구문
today = .saturday
print("Now it's \(today).") // 출력: Now it's saturday.
```

---

### 2. 열거형의 추가 핵심 기능 🌟

기본적인 사용법 외에도 Swift 열거형은 강력한 추가 기능을 제공합니다.

#### 가. 원시 값 (Raw Values)

각 열거형 케이스에 **고정된 기본 값 (원시 값)**을 할당할 수 있습니다. 원시 값은 숫자(정수, 실수), 문자, 문자열 타입이 될 수 있습니다. 각 케이스의 원시 값은 **유일해야** 합니다.

- **특징**:
    
    - 열거형을 정의할 때 각 케이스에 미리 값을 할당합니다.
    - 원시 값의 타입은 열거형 이름 뒤에 명시합니다.
    - `rawValue` 프로퍼티를 통해 원시 값에 접근할 수 있습니다.
    - 원시 값으로 열거형 인스턴스를 생성할 수도 있습니다 (실패 가능한 이니셜라이저 `init?(rawValue:)`).
- **예시**:
    
    ```Swift
    // 문자열 원시 값
    enum CompassPoint: String {
        case north = "북"
        case south = "남"
        case east = "동"
        case west = "서"
    }
    
    // 정수 원시 값 (자동 증가)
    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        // mercury가 1이면, venus는 2, earth는 3으로 자동 할당
    }
    
    let myDirection = CompassPoint.east
    print("방향: \(myDirection.rawValue)") // 출력: 방향: 동
    
    if let thirdPlanet = Planet(rawValue: 3) {
        print("3번째 행성: \(thirdPlanet)") // 출력: 3번째 행성: earth
    }
    
    // 원시 값이 없는 경우
    let unknownPlanet = Planet(rawValue: 99)
    print(unknownPlanet) // 출력: nil
    ```
    

#### 나. 연관 값 (Associated Values)

열거형의 각 케이스가 **다른 타입의 추가 정보 (연관 값)**를 저장하도록 할 수 있습니다. 이는 특정 케이스에 대한 컨텍스트 데이터를 제공할 때 유용합니다.

- **특징**:
    
    - 각 케이스마다 다른 타입과 개수의 연관 값을 가질 수 있습니다.
    - 원시 값과 달리, 연관 값은 열거형 인스턴스를 생성할 때 설정되며, 케이스마다 다를 수 있습니다.
    - 하나의 열거형에서 원시 값과 연관 값을 동시에 사용할 수는 없습니다.
- **예시**:
    
    ```Swift
    enum Barcode {
        case upc(Int, Int, Int, Int) // UPC 바코드는 4개의 정수 값을 가짐
        case qrCode(String)         // QR 코드는 문자열 값을 가짐
    }
    
    var productBarcode = Barcode.upc(8, 85909, 51226, 3)
    print("UPC 바코드: \(productBarcode)")
    
    productBarcode = .qrCode("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    print("QR 코드: \(productBarcode)")
    
    // 연관 값 사용 (switch 문과 함께 자주 사용)
    switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
    }
    // 출력: QR code: ABCDEFGHIJKLMNOPQRSTUVWXYZ.
    ```
    

#### 다. 메서드 및 계산된 프로퍼티 (Methods and Computed Properties)

구조체나 클래스처럼 열거형도 **메서드**와 **계산된 프로퍼티**를 가질 수 있습니다.

- **예시**:
    
    ```Swift
    enum Beverage {
        case coffee(isDecaf: Bool)
        case tea(type: String)
        case juice(fruit: String)
    
        // 계산된 프로퍼티
        var description: String {
            switch self {
            case .coffee(let isDecaf):
                return isDecaf ? "디카페인 커피" : "커피"
            case .tea(let type):
                return "\(type) 티"
            case .juice(let fruit):
                return "\(fruit) 주스"
            }
        }
    
        // 메서드
        func announce() {
            print("\(self.description) 나왔습니다!")
        }
    }
    
    let myDrink = Beverage.coffee(isDecaf: true)
    print(myDrink.description) // 출력: 디카페인 커피
    myDrink.announce()         // 출력: 디카페인 커피 나왔습니다!
    
    let anotherDrink = Beverage.juice(fruit: "오렌지")
    anotherDrink.announce()    // 출력: 오렌지 주스 나왔습니다!
    ```
    

#### 라. 모든 케이스 순회 (Iterating Over Enum Cases)

열거형이 `CaseIterable` 프로토콜을 채택하면, `allCases`라는 타입 프로퍼티를 통해 모든 케이스의 컬렉션을 얻을 수 있습니다. 이는 원시 값이나 연관 값이 없는 간단한 열거형에 유용합니다.

- **예시**:
    
    ```Swift
    enum Season: CaseIterable {
        case spring, summer, autumn, winter
    }
    
    let numberOfSeasons = Season.allCases.count
    print("계절의 수: \(numberOfSeasons)") // 출력: 계절의 수: 4
    
    for season in Season.allCases {
        print(season)
    }
    // 출력:
    // spring
    // summer
    // autumn
    // winter
    ```
    

---

### 3. 연관 학습 내용 📚

열거형을 이해했다면 다음 개념들을 학습하여 Swift 프로그래밍 능력을 더욱 향상시킬 수 있습니다.

#### 가. Switch 문과 열거형 (Switch Statements with Enums)

- **핵심**: 열거형은 `switch` 문과 환상의 조합을 이룹니다. `switch` 문을 사용하면 열거형의 각 케이스에 대해 다른 코드를 실행할 수 있습니다.
    
- **완전성 (Exhaustiveness)**: Swift의 `switch` 문은 열거형의 모든 케이스를 다루도록 강제합니다 (또는 `default` 케이스를 사용). 이는 잠재적인 버그를 줄이는 데 큰 도움이 됩니다.
    
    ```Swift
    let currentDay = Weekday.wednesday
    
    switch currentDay {
    case .monday:
        print("월요병...")
    case .tuesday:
        print("화요일")
    case .wednesday:
        print("주중의 중간!")
    case .thursday:
        print("목요일")
    case .friday:
        print("금요일! 곧 주말!")
    case .saturday, .sunday: // 여러 케이스를 묶을 수 있음
        print("신나는 주말!")
    // Weekday의 모든 케이스가 다뤄졌으므로 default가 필요 없음
    }
    ```
    

#### 나. 옵셔널 (Optionals)과 열거형

- **핵심**: Swift의 `Optional` 타입 자체가 사실은 `none`과 `some(Wrapped)` 두 가지 케이스를 가진 열거형입니다.
    
- **연관성**: 열거형을 사용하여 좀 더 명시적인 '값이 없음' 또는 다양한 상태를 표현할 수 있습니다. 예를 들어, 네트워크 요청의 결과를 나타내는 열거형(`success(Data)`, `failure(ErrorDescription)`, `notAttempted`)을 만들 수 있습니다.
    
    ```Swift
    // Optional<Wrapped>의 간략화된 정의
    /*
    enum Optional<Wrapped> {
        case none
        case some(Wrapped)
    }
    */
    
    var optionalName: String? = "홍길동"
    optionalName = nil
    
    // 사용자 정의 상태 예시
    enum FetchResult {
        case success(data: String)
        case failure(error: String)
        case loading
    }
    
    var currentStatus = FetchResult.loading
    // ... 이후 상태 변경
    // currentStatus = .success(data: "데이터 가져오기 성공!")
    // currentStatus = .failure(error: "네트워크 오류")
    ```
    

#### 다. 오류 처리 (Error Handling)와 열거형

- **핵심**: Swift의 오류 처리는 `Error` 프로토콜을 따르는 타입을 사용하는데, 열거형은 이 `Error` 프로토콜을 채택하여 사용자 정의 오류 타입을 만드는 데 매우 적합합니다.
    
- **장점**: 특정 작업에서 발생할 수 있는 다양한 오류 상황을 명확하게 정의하고 처리할 수 있습니다.
    
    ```Swift
    enum MyCustomError: Error {
        case invalidInput(reason: String)
        case networkUnavailable
        case fileNotFound(path: String)
    }
    
    func processFile(path: String) throws {
        if path.isEmpty {
            throw MyCustomError.invalidInput(reason: "파일 경로가 비어있습니다.")
        }
        // ... 파일 처리 로직 ...
        // if 파일이_없으면 {
        //     throw MyCustomError.fileNotFound(path: path)
        // }
    }
    
    do {
        try processFile(path: "")
    } catch MyCustomError.invalidInput(let reason) {
        print("입력 오류: \(reason)")
    } catch MyCustomError.fileNotFound(let path) {
        print("파일을 찾을 수 없음: \(path)")
    } catch {
        print("알 수 없는 오류: \(error)")
    }
    ```
    

#### 라. 프로토콜 (Protocols)과 열거형

- **핵심**: 열거형도 클래스나 구조체처럼 프로토콜을 채택(conform)할 수 있습니다. 이를 통해 공통 인터페이스를 구현하고 다형성을 활용할 수 있습니다. (`CaseIterable`도 프로토콜의 한 예입니다.)
    
    ```Swift
    protocol Describable {
        func getDescription() -> String
    }
    
    enum Transportation: Describable {
        case car(brand: String)
        case train(lineNumber: Int)
        case bus
    
        func getDescription() -> String {
            switch self {
            case .car(let brand):
                return "\(brand) 자동차"
            case .train(let lineNumber):
                return "\(lineNumber)호선 열차"
            case .bus:
                return "버스"
            }
        }
    }
    
    let myRide: Describable = Transportation.train(lineNumber: 2)
    print(myRide.getDescription()) // 출력: 2호선 열차
    ```
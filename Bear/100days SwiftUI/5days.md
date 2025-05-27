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
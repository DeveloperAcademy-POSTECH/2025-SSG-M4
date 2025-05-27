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
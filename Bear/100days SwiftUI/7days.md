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
# SwiftUI Core Data 완벽 가이드

Tags: #SwiftUI #CoreData #iOS #데이터베이스 

> [!info] Core Data란?
> **Core Data**는 애플리케이션의 데이터를 사용자의 기기에 저장하고, 관리하고, 가져오기 위한 애플의 공식 프레임워크입니다. 앱의 데이터를 영구적으로 보관해야 할 때 사용합니다.

> [!question] Core Data는 데이터베이스인가요?
> 정확히 말하면 데이터베이스 그 자체는 아닙니다. Core Data는 내부적으로 **SQLite** 데이터베이스를 사용하지만, 개발자가 복잡한 SQL 쿼리문 없이도 데이터를 쉽게 다룰 수 있도록 도와주는 **객체 지향적인 관리 도구(Object-Graph Management Framework)**입니다.
> 
> 마치 레고 블록(Core Data)을 조립해서 멋진 집(데이터 관리 시스템)을 만드는 것과 같습니다.

---

## 🏛️ Core Data의 핵심 개념

Core Data를 이해하기 위한 가장 중요한 빌딩 블록들입니다.

### `NSManagedObjectModel` (데이터 설계도)
- **역할**: 앱 데이터의 구조를 정의하는 '설계도'입니다.
- **비유**: 건물의 청사진. '메모' Entity는 '제목', '내용', '날짜' Attribute를 가질 것이라고 정의합니다.
- **실체**: Xcode 프로젝트의 `.xcdatamodeld` 파일.

### `Entity` & `Attribute` (개체와 속성)
- **Entity**: 데이터의 한 종류. (예: `메모`, `사용자`, `할일`)
- **Attribute**: Entity가 가지는 구체적인 속성. (예: `제목(String)`, `생성일(Date)`)

### `NSManagedObject` (실제 데이터 한 줄)
- **역할**: 설계도(`Entity`)를 바탕으로 만들어진 실제 데이터 객체 하나하나입니다.
- **비유**: "Swift 공부하기"라는 제목의 메모 한 개.

> [!tip] 가장 중요한 개념: `NSManagedObjectContext`
> - **역할**: 데이터를 읽고, 쓰고, 지우는 모든 작업이 일어나는 **'임시 작업 공간'**입니다.
> - **특징**: Context에서 데이터를 변경해도 `save()` 메소드를 호출하기 전까지는 실제 디스크에 저장되지 않습니다. 이 덕분에 여러 작업을 한 번에 처리하거나, 변경 사항을 취소(Undo)하는 기능이 용이합니다.

### `NSPersistentContainer` (저장소 관리자)
- **역할**: 위에서 설명한 `ObjectModel`, `Context` 등 Core Data의 복잡한 구성 요소들을 하나로 묶어 쉽게 사용할 수 있도록 제공하는 '컨테이너' 또는 '상자'입니다.

---

## 🏗️ SwiftUI에서 Core Data 사용 방법 (단계별 가이드)

### 1단계: Core Data를 포함한 프로젝트 생성
Xcode에서 새 프로젝트를 생성할 때 **"Use Core Data"** 옵션을 체크합니다.
- `[AppName].xcdatamodeld` 파일 (데이터 설계도)
- `Persistence.swift` 파일 (Core Data 설정 관리)
이 두 가지가 자동으로 생성됩니다.

### 2단계: 데이터 모델링 (`.xcdatamodeld`)
1.  `.xcdatamodeld` 파일을 엽니다.
2.  **"Add Entity"** 버튼으로 `Memo` Entity를 추가합니다.
3.  `Memo` Entity를 선택하고, Attributes 섹션에서 `+` 버튼을 눌러 속성을 추가합니다.
    - `title`: `String`
    - `content`: `String`
    - `createdAt`: `Date`

### 3단계: SwiftUI 뷰와 Core Data 연결하기
`[AppName]App.swift` 파일에서 `ContentView`에 `managedObjectContext`를 환경 변수로 주입합니다. Xcode가 이미 설정해 줍니다.

```swift
@main
struct MemoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
```

### 4단계: 데이터 가져오고 표시하기 (`@FetchRequest`)
SwiftUI의 `@FetchRequest` 프로퍼티 래퍼를 사용해 데이터를 손쉽게 가져옵니다. 데이터가 변경되면 뷰가 자동으로 업데이트됩니다.

```swift
// ContentView.swift

import SwiftUI
import CoreData

struct ContentView: View {
    // 1. Core Data의 Context(작업 공간)를 환경에서 가져오기
    @Environment(\.managedObjectContext) private var viewContext

    // 2. @FetchRequest로 데이터 가져오기 (createdAt 기준으로 내림차순 정렬)
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.createdAt, ascending: false)],
        animation: .default)
    private var memos: FetchedResults<Memo>

    var body: some View {
        NavigationView {
            // 3. 가져온 데이터를 List로 표시하기
            List {
                ForEach(memos) { memo in
                    VStack(alignment: .leading) {
                        Text(memo.title ?? "제목 없음")
                            .font(.headline)
                        Text(memo.createdAt!, formatter: itemFormatter)
                            .font(.caption)
                    }
                }
                .onDelete(perform: deleteMemos)
            }
            .navigationTitle("메모")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addMemo) {
                        Label("Add Memo", systemImage: "plus")
                    }
                }
            }
        }
    }
    // ... 함수들은 아래에 ...
}
```

### 5단계: 데이터 추가, 수정, 삭제 (CRUD)
모든 데이터 조작은 `viewContext`를 통해 이루어지며, 작업 후에는 반드시 `save()`를 호출해야 합니다.

```swift
// ContentView.swift 안에 이어서 작성

private func addMemo() {
    withAnimation {
        // 새 Memo 객체를 Context에 생성
        let newMemo = Memo(context: viewContext)
        newMemo.createdAt = Date()
        newMemo.title = "새로운 메모 \(Int.random(in: 1...100))"
        newMemo.content = ""

        // 변경사항을 실제 디스크에 저장
        saveContext()
    }
}

private func deleteMemos(offsets: IndexSet) {
    withAnimation {
        // 선택된 객체들을 Context에서 삭제
        offsets.map { memos[$0] }.forEach(viewContext.delete)

        // 변경사항(삭제)을 실제 디스크에 저장
        saveContext()
    }
}

private func saveContext() {
    do {
        try viewContext.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
```
> [!note] `saveContext()` 함수
> 반복되는 `do-catch` 블록을 별도의 함수로 분리하면 코드가 더 깔끔해집니다.

---

## ✅ 장점 vs ❌ 단점

### 👍 장점
- **강력하고 안정적**: 애플이 수년간 다듬어 온 프레임워크
- **대용량 데이터 처리**: 메모리 사용량 최적화
- **Undo/Redo 지원**: `Context` 기반 동작으로 변경사항 되돌리기 용이
- **오프라인 지원**: 네트워크 연결 없이 기기 내 데이터 관리
- **Xcode 통합**: 편리한 데이터 모델 편집기 제공

### 👎 단점
- **초기 학습 곡선**: 생소한 개념들로 인해 배우기 어려울 수 있음
- **보일러플레이트 코드**: 초기 설정 코드가 다소 길고 복잡함
- **과도한 기능**: 간단한 데이터를 저장하기에는 너무 무거움 (이 경우 `UserDefaults`가 더 적합)

---

> [!faq] 최신 동향: SwiftData
> 최근 애플은 **SwiftData**라는 새로운 데이터 관리 프레임워크를 발표했습니다. SwiftData는 Core Data의 강력함은 유지하면서, 훨씬 더 간결하고 Swift 친화적인 코드로 데이터를 다룰 수 있게 해줍니다.
>
> 하지만 Core Data의 개념과 동작 원리는 SwiftData의 근간을 이루므로, Core Data를 이해하면 SwiftData를 훨씬 쉽게 배울 수 있고 기존의 수많은 앱을 유지보수하는 데에도 필수적입니다.
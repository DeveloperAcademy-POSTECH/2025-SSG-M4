

### 미리 타입을 선언해주면 유지보수에도 유리하고, 타입을 명시적으로 네이밍 할 수 있어서 가독성에도 유리하다! 

실제 사용했던 알고리즘 풀이 예시
- `(start: Int, end: Int, profit: Int)`였는데, 중간에 계속 추가가 될 수 있는데, 미리 `Talk`로 선언해줘서 계속 수정하는데에 리소스가 덜들어감 
```swift hl:3,7
import Foundation

typealias Talk = (start: Int, end: Int, profit: Int)

func solution(_ N: Int, _ arr: [(Int, Int)]) -> Int {
    var answer = 0
    var tmpArr = [Talk]()

    func dfs(day: Int, profit: Int) {
        if day > N {
            answer = max(answer, profit)
            return
        }
        if let talk = tmpArr.first(where: { $0.start == day }) {
            dfs(day: talk.end + 1, profit: profit + talk.profit)
        }

        dfs(day: day + 1, profit: profit)
    }

    for (idx, item) in arr.enumerated() {
        let start = idx + 1
        let end = start + item.0 - 1
        let profit = item.1
        // 일단 완성일 기준 퇴사상태인거 다 걸러주기
        if end <= N {
            tmpArr.append((start: start, end: end, profit: profit))
        }
    }

    dfs(day: 1, profit: 0)
    return answer
}

```
## 🔗 문제 링크
[3sum-closest](https://leetcode.com/problems/3sum-closest/)

## ✨ 수도 코드
Medium 중에 정답률 50% 미만이라서, 당연히 맘편하게 O(n^3)로 풀 수 있다는 건 기대도 안했고, 어떻게 O(n^2)로 돌릴까 고민하다가 투포인터 썼어요 ! 
1. for문으로 처음 잡을 친구 하나 픽스하고
2. 나머지 2개를 이제 left , right 투포인터로 굴려주면서 비교 해줬습니다.
3. `abs(3개의 합 - target)`이 가장 작은걸 찾는게 목표라서 이걸 따로 함수로 뺐어요.
4.  `abs(3개의합 - target)`이 `target`보다 작으면 `left를 +=1` , 반대는 `right-=1` , else ( 0 이면 그거 자체가 정답 , target에 그대로 도착했으니까 ) `return target`


## answer값 변경사

```swift
//        var answer = 3000 // 최대값 범위 3개 더한 것 으로 해줬는데, target이 높아서 이렇게 해주면 틀리다고 뜸 !
//        ar answer = Int.max // 하니까 터짐
        var answer = Int(Int32.max) // max값에 +가 조금이라도 되니까 펑 터져버리는 이슈가 있음
```

```swift title:전체코드 error:11 warn:12 
import Foundation

// abs(sum - target)가 가장 작은애 찾기

class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        func caculate(_ sum: Int) -> Int {
            return abs(sum - target)
        }

//        var answer = Int.max // 터짐 - max값에 +가 조금이라도 되니까 펑 터져버리는 이슈가 있음
        var answer = Int(Int32.max) // 그래서 그나마 값이 조금 작은 큰값으로 해결 
        var nums = nums
        nums.sort(by: <)
        let LEN = nums.count
        for i in 0 ..< LEN - 2 {
            var left = i + 1
            var right = LEN - 1
            while left < right {
                let totalSum = nums[i] + nums[left] + nums[right]
//                print(nums[i], nums[left], nums[right])
//                print(totalSum)
//                print(caculate(totalSum))
                if caculate(totalSum) < caculate(answer) {
//                    print(nums[i], nums[left], nums[right])
                    answer = totalSum
                }
                if totalSum < target {
                    left += 1
                } else if totalSum > target {
                    right -= 1
                } else {
                    return target
                }
            }
        }
        return answer
    }
}

print(Solution().threeSumClosest([1, 1, 1, 1], -100))
```
### `var answer = Int.max`
- <img width="477" alt="스크린샷 2025-05-23 오후 4 11 17" src="https://github.com/user-attachments/assets/422a3517-aac0-4908-a493-104873611317" />
- **Int.max로 해주니까  계산하는 과정에 있어서 여기서 + 100 만 되더라도 터짐!! 인트초과! 그래서 그정도까지 큰 값은 피해야하는 상황**

### `var answer = Int(Int32.max)`
- Int64보다 적은 `Int32` Max값으로서 max값을 가져와서 터지지 않게 조정

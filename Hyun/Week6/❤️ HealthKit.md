https://developer.apple.com/documentation/healthkit
> 사용자의 건강 및 운동 관련 데이터를 앱이 **안전하게 접근·추가·읽기**할 수 있도록 해주는 **Apple 프레임워크**
- iOS 기기 내의 **[[Health 앱 Browse 탭 기능]]**과 연동
- iPhone, Apple Watch, 기타 센서에서 수집됨

## ⚙️ 주요 기능
- **데이터 통합**
	- 다양한 앱과 기기에서 **수집한 건강 데이터**를 Health 앱에서 **통합 관리**
- **데이터 읽기/쓰기**
	- 앱이 **허용된 건강 데이터를 읽고 기록**
- **개인정보 보호**
	- 사용자의 명시적인 **동의** 없이는 어떤 **데이터도 접근** 불가
	- 앱이 HealthKit에서 어떤 항목을 읽을지/쓸지를 명확히 지정하고, 사용자에게 권한 요청
	- Ex)
		```swift
import HealthKit

let healthStore = HKHealthStore()

// 1. 읽을 데이터 명시
let readTypes: Set<HKObjectType> = [
    HKObjectType.quantityType(forIdentifier: .stepCount)!  // 걸음 수 읽기
]

// 2. 쓸 데이터 명시
let writeTypes: Set<HKSampleType> = [
    HKObjectType.quantityType(forIdentifier: .bodyMass)!  // 체중 쓰기

]

// 3. 사용자 권한 요청
healthStore.requestAuthorization(toShare: writeTypes, read: readTypes) { success, error in
    if success {
        print("HealthKit 접근 허용됨")
    } else {
        print("HealthKit 접근 거부됨: \(error?.localizedDescription ?? "알 수 없음")")
    }
}
		```
- **건강 지표 추적**
	- 심박수, 걸음 수, 체중, 수면, 칼로리 등 **다양한 건강 정보 추적**
	- Ex)
		```swift
let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
let quantity = HKQuantity(unit: HKUnit.count().unitDivided(by: HKUnit.minute()), doubleValue: 78)

let sample = HKQuantitySample(
    type: heartRateType,
    quantity: quantity,
    start: Date(),
    end: Date()
)
		```
- **건강 분류 체계**
	- **데이터를 구조화**하여 여러 단위로 나눔
	- Ex) HKQuantityType, HKCategoryType

## 📦 데이터 타입
- **HKQuantityType**
	- 수치 기반의 건강 데이터
	- Ex) 심박수, 체중, 걸음 수 등
- **HKCategoryType**
	- 상태/범주 기반 데이터
	- Ex) 수면 상태, 생리 주기 등
- **HKWorkoutType**
	- 운동 기록
	- Ex) 운동 시간, 거리, 칼로리 등
- **HKCharacteristicType**
	- 변경되지 않는 사용자 정보
	- Ex) 생년월일, 성별 등
- HKCorrelationType
	- 여러 값을 함께 저장
	- Ex) 혈압(수축기/이완기) 등
- **HKDocumentType**
	- PDF 등 문서 기반 의료 정보
	- Ex) 의료기관 문서 등

## 🛞 구성 요소
- `HKHealthStore`
	- HealthKit의 중심 객체
	- 데이터 요청/저장 등 담당
	- `let healthStore = HKHealthStore()`
- `HKObjectType`
	- 모든 Health 데이터 타입을 표현
	- `stepCount`, `sleepAnalysis`, `heartRate` 등
- `HKSample`
	- 실제 하나의 데이터 기록 (값 + 시간 포함)
	- `HKQuantitySample`, `HKCategorySample`
- `HKQuantityType`
	- 숫자 데이터 타입
	- 걸음 수, 칼로리, 심박수 등
- `HKCategoryType`
	- 상태형 데이터 타입
	- 수면, 명상, 생리 등
- `HKCharacteristicType`
	- 사용자 특징 정보
	- 성별, 생일 등 (읽기 전용)
- `HKWorkout`
	- 운동 기록 전체 세션 단위
	- 운동 시간, 거리, 칼로리 등
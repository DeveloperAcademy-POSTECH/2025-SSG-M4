Foundation Models Framework에서, AI 모델이 단순히 텍스트 생성만 하는 것을 넘어, 앱 안에 정의된 Swift 함수(도구, 기능)를 실제로 호출해서 실행할 수 있도록 해주는 기능이다.
> 모델이 현실 세계의 정보(날씨, 일정, 데이터 등)를 실시간으로 반영해 응답할 수 있게 한다.

## 작동 흐름
1. Tool 정의
	- 개발자가 Swift에서 `Tool` 프로토콜을 채택한 타입(Struct/class)을 만든다.
	- 각 Tool은 이름, 설명, 입력값 타입(Arguments), 결과값 타입(Result), 그리고 실제 동작을 수행하는 `call` 메서드를 가집니다.
	- Arguments와 Result 모두  [[@Generable]]로 구조화되어 타입 안전성을 보장합니다.
2.	Tool 등록
	- 세션(LanguageModelSession) 생성 시, 사용할 Tool들을 등록합니다.
	- 한 세션에 여러 Tool을 동시에 등록할 수 있습니다.
3.	프롬프트 입력 및 Tool 호출
	- 사용자가 자연어로 요청(프롬프트)을 입력합니다.
	- AI 모델은 이 프롬프트를 분석해, Tool 호출이 필요한지 판단합니다.
	- 필요하다면, 분석한 프롬프트에서 Arguments를 생성해 Tool의 call 메서드를 실행합니다.
4.	Tool 실행 및 결과 반환
	-  Tool의 call 메서드가 실제 데이터를 가져오거나 기능을 수행합니다.
	- 결과는 ToolOutput 형태로 반환되어, AI 모델이 최종 응답을 생성할 때 활용됩니다.
5.	최종 응답 생성
	- AI 모델은 Tool의 결과와 기존 대화 맥락을 바탕으로, 사용자에게 최종 답변을 제공합니다.
	- 한 요청에서 여러 Tool을 연속 또는 병렬로 호출할 수도 있습니다.

작동 흐름 코드 예시
```swift
1. Tool 정의
@Generable
struct WeatherArguments {
    let city: String
}

@Generable
struct WeatherResult {
    let temperature: Double
}

struct WeatherTool: Tool {
    let name = "weather"
    let description = "도시의 현재 기온을 알려줍니다."

    func call(arguments: WeatherArguments) async throws -> Output {
        // arguments.city를 사용하여 부산 지역의 날씨 데이터 처리
        let temp = 24.0 // "예시 온도
        return .generatedContent(WeatherResult(temperature: temp))
        //generatedContent: 결과값을 감싸는 Wrapper, 타입 안정성, 구조 일치성                             보장
    }
}

2. Tool 등록
let session = LanguageModelSession(
    tools: [WeatherTool()],
    instructions: "여행 정보를 친절하게 안내해 주세요."
)

3. 프롬프트 입력 및 Tool 호출
// 사용자가 자연어로 프롬프트를 입력
let prompt = Prompt("부산 날씨 알려줘")
// 프레임워크는 프롬프트("부산 날씨 알려줘")를 모델에 전달
// AI 모델은 프롬프트를 분석해 Tool 호출이 필요하다고 판단
// "부산"이라는 정보를 추출해 WeatherArguments(city: "부산") 생성
// Tool의 call 메서드를 자동으로 실행

4. Tool 실행 및 결과 반환
// call 메서드가 실행되어 WeatherResult(temperature: 24.0)를 반환
// 프레임워크는 이 결과를 Output으로 받아 AI 모델에 전달

5. 최종 응답 생성
let response = try await session.respond(to: prompt)
// AI 모델은 Output(WeatherResult)을 바탕으로 자연어 응답 생성
print(response)
// 예시 출력: "현재 부산의 기온은 24도입니다."
```
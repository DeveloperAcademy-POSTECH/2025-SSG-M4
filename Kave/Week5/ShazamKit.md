## ShazamKit
![[ShazamKit.png]]

2017년, Apple은 음악 인식 소프트웨어인 'Shazam'을 인수하였고, 해당 기능을 WWDC22를 기점으로 iOS에서 간편하게 사용할 수 있도록 'ShazamKit'을 통하여 API를 공개하였다.
https://www.shazam.com/ko-kr/shazamkit

![[ShazamKitStructure.png]]

ShazamKit은, '음악 인식' 소프트웨어인 Shazam의 기능을 지원하는데, 위와 같은 구조로 이루어진다. 

우선, 입력받은 음성을 **Signature**라는 형식으로 변환 한 뒤 해당 음악을 Shazam의 데이터베이스와 비교하며 매칭을 하게 된다. 

이 과정에서 **Audio Buffer Stream** 혹은 **Signature Data**를 **ShazamKit Session**으로 전달하게 되고, 이 전달 된 데이터를 기반으로 ShazamKit은 Shazam목록 혹은 Custom 목록에서 **Signature Data**를 와 매칭되는 오디오를 찾게 되며

만약 매칭되는 오디오가 있을 경우 **Session**은 매칭된 오디오의 메타 데이터를 포함한 **Media Item**을 반환하게 되고 앱은 이 **Media Item**을 표시해주게 된다.

특이한 부분이라면, 원본 소리 데이터가 변환된 자료인 **Signature** 는 다시 원본 파일로 바꿀 수 없는데, 이는 사용자의 개인정보를 지키기 위하여 변환할 수 없도록 되어있다.


>[!question]
>Q. 그러면, ShazamKit은 백그라운드에서 동작이 가능한가요? 

아쉽게도, 불가능하다. 

ShazamKit 내에서는 **SHManagedSession**라는 객체가 존재하는데, 해당 객체는 일반적으로는 Shazam Catalog나 Custom Catalog에 있는 음악들과 녹음된 소리를 일치하는지 확인하고 기록하는 객체이다.

그러나 이 객체는, ShazamKit이 돌아가고 있는 앱이 백그라운드 상태로 진입 할 경우 약 20초가 지나면 곡을 분석하는것을 종료한다. 

즉, ShazamKit을 사용하기 위해서는 앱이 항상 Foreground에서 동작하고 있어야 하는 것이다.

## Getting Started with ShazamKit
우선, 당연하게도 ShazamKit은 마이크를 사용하기에 ``info.plist``에서 마이크 사용 설명을 추가해주어야 한다. 

초기화 단계에서는, PCMbuffer를 받기 위해 tap을 설치하고 Audio Engine을 준비하게 된다.

```Swift
private func configureAudioEngine() {
	let inputNode = audioEngine.inputNode
	let recodringFormat = inputNode.outputFormat(forBus: .zero)
	inputNode.installTap(onBus: .zero, bufferSize: 8192, format: recordingFormat) {[weak self] (buffer, time) in 
	self?.session.matchStreamingBuffer(buffer, at: time)
	}
	
audioEngine.prepare()
}
```

Audio Engine이 준비되었다면, ``match()`` 메소드다. 
해당 메소드는, 우리가 일반적으로 Shazam을 사용하는 버튼을 누를 때 호출되게 된다.

이때, 앱에서 일어나는 과정을 간결하게 표시해보면

>마이크 접근 요청
>-> 허용
>-> 녹음 시작을 위해 Audio Engine 호출
>-> UI에게 매칭 시작 알림 던지기
>-> session.results 호출하여 매칭 결과의 비동기 시퀀스를 기다리기

만약 여기에서 매칭이 성공하였다면 매칭된 결과를 보여주게 되고, 매칭에 실패하였다면 해당 상황에 대해 설정된 내용이 실행될 것이다.

```Swift
func match() async {
	let granted = await AVAudioApplication.requestRecordPermission()
    
    guard granted else {
    	print("No recording permission granted ...")
        return
    }
    
    do {
    	try audioEngine.start()
    } catch {
    	print("Failed to start audio engine")
        return
    }
    
    isMatching = true
    
    for await result in session.results {
    	switch result {
        case .match(let match):
        	Task { @MainActor in
            	self.currentMatchResult = MatchResult(match: match)
            }
        case .noMatch(_):
        	print("No match")
            endSession()
        case .error(let error, _):
        	print("Error \(error.localizedDescription)")
            endSession()
        }
        stopRecording()
    }
}
```

이렇게만 보면... 복잡해 보이지만

위에서 잠깐 언급하였던 ``SHManagedSession``을 사용하면 이러한 과정을 훨신 간단하게 사용할 수 있다. [[UIKit]]에서 설명했던 내용과 비슷하다. 

실제로 위 과정을, 만약 ``SHManagedSession``을 통해서 사용하게 된다면

우선 
``let managedSession = SHManagedSession()`` 
을 통해서 인스턴스를 하나 생성해준다. 

이후, Session 의 result()를 호출해서 결과값을 기다리고 해당 결과값에 따라 Switch문이 동작하게 된다.

```swift
let result = await managedSession.result()

// result 값에 따라 switch문 동작
switch result {
	case .match(let match):
    	print("Match found. MediaItemsCount: \(match.mediaItems.count)")
    case .noMatch(_):
    	print("No match found")
    case .error(_, _):
    	print("An error occurred")
}
```

복잡한 과정은, 미리 생성되어있는 API가 처리해주고, 결과값만 받아올 수 있는 것이다.

``SHManagedSession``, 즉 Shazam의 Session을 관리해준다는 의미인데

이 Session에 대해서 ShazamKit이 어떻게 매칭을 진행할지에 대한 데이터를 준비할 수 있다.

![[ShazamKitPreparing.png]]

preparing 과정이 없이, 매칭이 이루어진다면 

우선 결과가 요청되고 -> 이에 대하여 Session이 매칭을 위해 리소스를 할당하고 -> 녹음을 진행한 뒤 -> 매치값이 리턴되게 된다.

preparing과정이 진행되고 매칭이 이루어진다면

prepare()과정이 진행되고 -> 리소스가 미리 할당되며 -> 사전 녹음이 시작되고 -> 결과 요청이 되었을 때 바로 매치값이 리턴될 수 있게 된다.

```swift
let managedSession = SHManagedSession()

await managedSession.prepare()

let result = await managedSession.result()
```

개발자가 직접 호출할 지 안할지를 선택할 수도 있고, ShazamKit을 통해서 이를 호출할 수도 있다.


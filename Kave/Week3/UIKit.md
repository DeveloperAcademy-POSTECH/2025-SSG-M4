## SwiftUI? UIKit?
Apple은, 개발자로 하여금 쉽고 간편하고, 더 간소화된 UI를 만들 수 있도록 2019년도에서 [[SwiftUI]] 를 발표한다. 

기존 AppKit, UIKit과 같이 여러 Swift언어들로 구성 된 프레임워크들을 인터페이스 영역에서 통합해서 SwiftUI라는 프레임워크 하나로 모든 플랫폼에서 사용할 수 있도록 한 것이다.

그러면 SwiftUI 이전, 오래전부터 사용되던 UIKit이란 무엇이며 왜 SwiftUI가 나온 지금도 계속해서 사용되고 있을까?

## UIKit
Apple Developer 사이트의 Documentation에 따르면, **UIKit**은

>Construct and manage a graphical, event-driven user interface for your iOS, iPadOS, or tvOS app.

으로 정의되고 있다. 그러니까, 사용자가 눈으로 보고 직접 경험하는 인터페이스를 구현하기 위한 **window**와 **view** 구조를 제공한다.

더욱 더 간단하게 이야기하면, [[SwiftUI]] 와 같이 UI를 구현하기 위해서 사용되는 프레임워크이다.

조금 더 개발적인 이야기를 해보자면, 

**UIKit**은 **명령형** 프레임워크이며
**SwiftUI**는 **선언형** 프레임워크이다.

그러면, **명령형** 이란 뭘까?

> [!note] 명령형 프로그래밍
> **명령형 프로그래밍**은 **선언형 프로그래밍**과 반대되는 개념으로, 프로그래밍의 **상태** 와 상태를 변경시키는 구문의 관점에서 연산을 설명하는 **프로그래밍 패러다임**의 일종이다. **자연 언어**에서의 **명령법**이 어떤 동작을 할 것인지를 명령으로 표현하듯이, 명령형 프로그램은 **컴퓨터**가 수행할 명령들을 순서대로 써 놓은 것이다.

**SwiftUI**에서 개발자가 이미 만들어져 있는 것 들을 이용하여 요소들을 불러왔다면 (실제로 이게 맞는지는 추후에 Deep-Dive가 필요할 것 같다.)
**UIKit**에서는 **어떻게(How)** 코드를 실행할지를 명확하게 지시하게 된다.


```Swift
import UIKit

class MyViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// UIButton 생성 및 설정
		let button = UIButton(type: .system)
		button.setTitle("Tap Me", for: .normal)
		button.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

		// UIView의 서브뷰로 추가
		view.addSubView(button)
	}

	@objc func buttonTapped() {
		print("Button was tapped!")
	}
}
```

구체적으로 버튼이 **어떻게** 생겼으며, **어떻게** 위치하고, **어떻게** 동작하는지를 모두 명령하고 있다.

![[UIKit-practice.png|300]]

만약 같은 기능을 **SwiftUI**로 만들어본다면

```Swift
import SwiftUI

struct SwiftUIView: View {
	var body: some View {
		VStack {
			Spacer()

			Button(action: {
				print("Button was tapped!")
			}) {
				Text("Tap Me")
					.foregroundColor(.blue)
			}
			Spacer()
		}
	}
}
```

위와 같이 될 것이다. 

단순한 예제를 사용했을때에는 **SwiftUI**가 훨씬 간단하며, 직관적으로 보이며 **UIKit**은 복잡하며 '이런 부분까지 지정해야한다고?' 라는 생각이 든다. 

그러면 왜 아직까지도 **UIKit** 을 사용하는걸까?

## Why UIKit?

**SwiftUI** 는 **선언형 프로그래밍**을 따르기 때문에, 데이터의 **상태**와 **UI**가 자동으로 동기화되고, **업데이트** 또한 자연스럽게 이루어진다. 

무엇보다 중요한건, **SwiftUI**에서 사용할 수 있는 다양한 ``contextMenu``, ``confirmationDialog``, 기타 요소들은 이미 사전에 선언되어있는대로 표시되고 동작하기에 개발자가 멋대로 요소를 건드리는것이 **불가능** 하다.

그렇기 때문에, **UIKit**을 사용하면 개발자는 스스로가 명령하는 대로 App 내부의 요소들이 표시되고 동작할 수 있도록 할 수 있다.

**UIKit**은 [[MVC Pattern]] 으로 구현되며 도식도는 아래와 같다.
![[UIKit-MVC.png]]

**SwiftUI**는 iOS 13 이상, 그마저도 일부 기능들은 최신 OS가 아니면 사용이 불가능하지만 **UIKit**은 iOS 2부터 시작하여 폭넓은 호환성을 제공한다.

다행히도, **UIKit**은 **SwiftUI**와 같이 사용이 가능하고, 실제로도 자주 사용된다. 
**SwiftUI**에서 ``UIViewRepresentable``, **UIKit**에서 ``UIHostingController``와 를 사용하여 서로가 서로의 컴포넌트를 사용할 수 있도록 지원된다.


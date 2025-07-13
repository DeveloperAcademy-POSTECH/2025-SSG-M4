## Delegate
Swift는, Apple이 제공하는 상당히 많은 API나 프레임워크들을 간단하게 사용할 수 있는데 이러한 프레임워크 대부분에서는 **Delegate**라는 패턴이 사용된다. 

**Delegate**란, '위임' 이라는 뜻을 가지고 있으며 흔히 객체 지향 프로그래밍의 핵심적인 디자인 패턴 중 하나로 알려저있다. '객체 합성이 상속과 동일하게 코드 재사용을 할 수 있도록 하는 디자인 패턴' 이라고 한다. 
약간 복잡하니 쉽게 이야기하자면, 서로 다른 객체간의 원활한 작업 및 원하는 결과를 얻기 위해서 만들어진 디자인 패턴 인 것이다.

그러면 애초에, 왜 **위임** 을 해야하는걸까? 그냥 미리 만들어두고 직접 사용하면 되는게 아닐까?
왜냐하면, 우리는 어떻게 작업이 이루어지는지 알 수 없기 때문이다. 

Apple은, 다양한 Kit들을 개발자들이 쉽게 접근하고 사용할 수 있게 해두었으나 그런 코드들을 우리가 직접 로직을 수정하거나 할 수는 없다. 이유는... 잘 모르겠지만 보안상의 문제라던가 본인들이 지향하는 HIG가 쉽게 어긋날 수 있기 때문이 아닐까?

그래서 예를 들어 ``UITableView`` 라는 ``UIKit``에서 표 한줄을 만드는 객체가 있다. 우리는 이 객체를 호출할 수 있고, 이 객체로 표를 만들수는 있지만 이 객체가 표를 표현하는 '방식' 자체를 바꿀수는 없다. 그렇기 때문에 하나의 '객체' 를 만들고, 그 객체에서 표에 어떤 내용이 들어갈지, 표가 어떻게 생길지를 정의를 한 뒤 ``UITableView`` 가 그 객체의 코드를 호출해줘야 한다. 그리고 이러한 디자인 패턴을 **Delegate** 패턴이라고 한다.

쉽게 말하면... 건물을 짓는다고 할 때 건물의 설계도와 짓는 방법을 알고있는 사람이 있고 건물이 어떤 크기, 어떤 재료로 만들어질지를 알고 있으며 그걸 직접 만들 수 있는 사람이 있다고 할 때 직접 만들 수 있는 사람에게 설계도를 주며 '이렇게 만들어' 라고 하는것이다. (틀릴 수도 있을 것 같다... 반대인가?)

```Swift
protocol ConstructionDelegate {

func prepareConstruction()

}

  

class ConstructionManager: ConstructionDelegate {

func prepareConstruction() {

print("설계도 보고, 자재 준비하고, 건설 준비 완료")

//보고하기()

}

}

  

class Gab {

var delegate: ConstructionDelegate?

  

func assignConstructionTask(){

print("어이 을씨, 건설 시작해")

delegate?.prepareConstruction()

}

}

  

let eul = ConstructionManager()

let gab = Gab()

  

gab.delegate = eul

gab.assignConstructionTask()
```

다음과 같이 볼 수 있을 것이다. (리오 고마워요)


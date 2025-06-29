## Reality? Kit?
ARKit은 이름만 보더라도 어떠한 기능을 지원하는 프레임워크인지 알 수 있다. AR, AugmentedReality Kit

이름 그대로 ARKit은 Swift를 통해서 구현되는 Apple 생태계의 앱들에서 AR 을 구현하는데 필수적인 추적, 고정, 스캔과 같은 다양한 기능들을 제공한다. 

그러면 RealityKit은 뭘까? 이름만 보자면 '현실적인' 도구 로 읽히게 된다. 

Apple Developer에 따르면, 

>RealityKit 프레임워크는 사진처럼 생생한 렌더링과 카메라 효과, 애니메이션, 물리적인 요소 등을 갖추고 특별히 증강 현실을 위해 완전히 새롭게 빌드되었습니다. RealityKit은 네이티브 Swift API, ARKit 통합, 놀랍도록 사실적인 물리적 요소 기반의 렌더링, 변형 및 골격 애니메이션, 공간 오디오 및 강체 물리 요소를 통해 AR 개발을 그 어느 때보다 빠르고 쉽게 수행할 수 있게 해줍니다.

라고 한다. 

즉, ARKit 위에서 ARKit을 통하여 고정된 증강현실에서 가상 콘텐츠들이 어떻게 보이고 어떻게 움직이며 어떤 작용을 하는지를 담당하는것이 RealityKit인 것이다.

과거 SceneKit이 존재하기는 하였으나 OpenGL 기반에서 시작하여 Metal을 지원하게 되어 구조적인 한계가 존재하였으며 이는 더욱 더 높은 폴리곤의 3D 렌더링과 물리 시뮬레이션 같은 부분에서의 비효율을 초래하였고 

점점 새롭게 추가되는 기능들 (LiDAR, Face Tracking 등) 을 지원하기에는 한계가 존재하였기에 Metal을 기반으로 더욱 더 확장성이 넓도록 새롭게 나온 프레임워크가 RealityKit인 것 이다. 

RealityKit은 WWDC19에서 발표되었으며 이번 WWDC25에서는 'SceneKit'이 iOS / iPadOS 26에서 더이상 사용이 권장되지 않게 될 것이라고 이야기가 되었다. 즉, Unity나 Unreal같은 엔진을 다룰것이 아니라면 우리는 지금 상황에서는 SceneKit을 배우기보다는 RealityKit을 배워야 한다.

## Getting started
![[xcode-reality-kit.png]]
AR App은 xcode에서 프로젝트를 새롭게 생성할 때 'Augumented Reality App'을 선택함으로서 만들 수 있다. 위와 같이 프로젝트를 생성하게 되면, 아래와 같은 코드가 사전에 생성이 되어있는것을 확인할 수 있다.

```Swift
import SwiftUI
import RealityKit

struct ContentView : View {

	var body: some View {
		RealityView { content in 
			//Create a cube model
			let model = Entity()
			let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
			let material = SimpleMaterial(color: .gray, rough: 0.15, isMetallic: true)
			model.components.set(ModelComponent(mesh: mesh, materials: [material]))
			model.position = [0, 0.05, 0]
			
			//Create horizontal plane anchor for the content
			let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
			anchor.addChild(model)
			
			//Add the horizontal plane anchor to the scene
			content.add(anchor)
			
			content.camera = .spatialTracking
		}
		.edgesIgnoringSafeArea(.all)
	}
}

#Preview {
	ContentView()
}
```

RealityKit은 원래는 UIKit과 마찬가지로 객체를 직접 생성하고, 구현을 하였어야 했으나 RealityKit 3.0을 기점으로 ``RealityView`` 라는 SwiftUI 에서 사용 가능한 View 덕분에 UIKit 없이 바로 RealityKitㅇㄹ 사용할 수 있게 되었다. 

```Swift
let model = Entity()
let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
let material = SimpleMaterial(color: .gray, rough: 0.15, isMetallic: true)
```
'어떠한 콘텐츠' 를 보여줄지 정의하는 부분이다.

``Entity()``는 3D 오브젝트의 최소 단위이며, 우선 model을 정의해준다. 

``MeshResource``에서의 ``Mesh``는, 3D 오브젝트가 어떻게 생겼고 어떻게 이루어져있는지를 의미한다. ``Mesh``는 수백, 수천, 수만개의 폴리곤 (삼각형, 사각형 평면) 으로 구성이 되어있고 ``MeshResource`` 를 통해서 이러한 ``Mesh``가 어떻게 렌더링되는지를 정의할 수 있다.

``SimpleMaterial``에서의 ``Material``은, 3D 오브젝트의 색, 질감, 반사, 투명도와 같은 '재질' 을 결정한다. ``Mesh`` 위에 ``Material``이 올라가며 하나의 3D 오브젝트가 탄생하는 것 이다. ``SimpleMaterial``은 RealityKit에서 제공하는 정말 간단한 ``Material``로, 빛에 반응하는 ``Material``을 생성해준다.
RealityKit에서는 ``CustomMaterial``, ``OcclusionMaterial``, ``PhysicallyBasedMaterial``, ``PortalMaterial``, ``ShaderGraphMaterial``, ``SimpleMaterial``, ``UnlitMaterial``, ``VideoMaterial``등과 같은 다양한 ``Material``들을 제공한다.

위 과정을 통해, 우리가 AR앱에서 보여주고자 하는 하나의 박스, 아니 3D로 구성된 ``Cube``가 정의된다.

```Swift
model.components.set(ModelComponent(mesh: mesh, materials: [material]))
model.position = [0, 0.05, 0]
```

이렇게 정의된 요소들은 , ``ModelComponent``를 통해서 ``Mesh``와 ``Material``이 ``model``에 적용이 되게 되며 
``.position``으로 어떠한 위치에  표시가 될 것인지 정해진다.

```Swift
let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
anchor.addChild(model)
```

다음으로는 ``Anchor``를 정의한다. 
``Anchor``는 '닻'을 의미하는데, 우리가 표현하고자 하는 가상의 콘텐츠가 실제 세계에서 어느 부분을 고정으로 잡고 표시될지를 정하는 어떻게 보면 AR앱을 만드는데 있어 제일 중요한 기능을 한다. 

``AnchorEntity`` 라는 객체를 통해서 그러한 '고정점' 을 정의하게 되는데, 우선 '아무(any)' '평면(plane)'위에 '수평(horizontal)' 을 인식하게 되며, 그러한 공간의 크기의 경우 ``SIMD2``를 통해서 정의가 되는데 ``SIMD2<Float>``는 3D 그래픽에서 주로 사용되는 개념이며 **2차원 벡터** 혹은 **2개의 숫자 묶음**을 나타내는 구조체이다. 위에서처럼 ``minimumBounds``를 ``SIMD2<Float>(0.2, 0.2)``로 정의하게 될 경우 최소한의 공간 크기를 20cm x 20cm으로 설정한다는 뜻 이다.

쉽게 이야기하면, 
'최소 20cm x 20cm 이상의 아무 평면에 앵커를 고정한다' 라는 뜻 이다.

이렇게 만들어진 ``Anchor``는

```Swift
content.add(anchor)
```

를 통해서 Scene에 추가가 되게 된다. 여기서 Scene은 SwiftUI의 View와 비슷하게 RealityKit을 통해서 구현되는 콘텐츠들이 보여지는 곳 을 의미한다.

그 다음으로는

```Swift
content.camera = .spatialTracking
```
``.spatialTracking`` 을 통해서 기기의 위치 및 방향을 실시간으로 추적하는 카메라를 보여주게 된다.

그런데, RealityKit은 모델링을 렌더링하고, 물리적인 작용만 보여주는 프레임워크가 아니였나?

사실, RealityKit은 단순히 하나의 프레임워크로 구성되는것이 아닌 ARKit에 렌더링과 물리엔진이 더해진, SceneKit과 다르게 처음부터 ARKit과 통합된 프레임워크이기 때문에 ARKit을 별도로 추가하지 않더라도 RealityKit 내부에서 ARKit을 호출하게 된다.

이렇게해서 구현된 AR컨텐츠는, 아래와 같이 보이게 된다.
![[realitykit-practice-app.png|300]]

제일 최초로 인식된 20x20 평면에 앵커가 설정되고, 그 앵커를 기준으로 해서 설정된 마테리얼과 메쉬값을 가지는 큐브가 보여진다. 

신기한점은, 이러한 큐브가 카메라를 움직임에 따라 초점이 맞았다, 안맞는걸 볼 수 있는데 이는 ARKit내부에서 처음에는 제대로 앵커를 잡지 못했다가 카메라를 움직일수록 더욱 더 평면 인식이 정확해지며 큐브가 고정되고 앵커가 고정되며 오브젝트가 안정화되며 초점이 제대로 맞게 된다. 

어떻게 보면, RealityKit이 복잡해보일수도 있지만 사실 Unity와 같은 게임 엔진들과 개념 자체는 비슷하다고 생각한다. 다만 이것을 실제로 Scene을 보면서 마우스를 통해서 설정을 하는지, 아니면 개발자가 IDE에서 타이핑을 직접 하면서 구현을 하는지의 차이라고 생각한다.





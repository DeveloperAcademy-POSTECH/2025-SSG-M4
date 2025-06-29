## Context Menu
![[components-context-menu.png]]

Context Menu (빠른 메뉴)는 기본적으로는 **숨겨져** 있는 메뉴로서, 사용자의 앱 경험속에서의 **멘탈 모델** 을 통한 동작으로 표시된다. 
- visionOS / iOS / iPadOS ->길게 터치, 핀치 제스처
- macOS / iPadOS -> Control키를 누르면서 포인팅 장치 클릭
- macOS / iPadOS -> 보조 클릭

SwiftUI, UIKit, AppKit을 통하여 사용이 가능하나 SwiftUI에서는 이미 지정되어있는 형식의 빠른 메뉴만 사용이 가능하며 (커스텀 불가) 다양한 형태의 디자인에 맞추어 빠른 메뉴를 만들기 위해서는 UIKit의 사용이 필요하다.
## SwiftUI
```Swift
nonisolated 
func contextMenu<MenuItems>(@ViewBuilder menuItems: () -> MenuItems) -> some View where MenuItems : View
```

``contextMenu(menuItems:)``
- 간단하게 원하는 View에 빠른 메뉴를 적용할 수 있다
- ``menuItems`` 클로저에 ``Button``, ``Toggle``, ``Picker`` 등을 추가할 수 있다. 
- ``menuItmes`` 클로저에 아무것도 없다면 빠른 메뉴가 비활성화 된다.

Practice 폴더 내의 [[ContextMenu.swift]] 를 확인해보면
```Swift
...

.contextMenu {
	Button(role: .destructive, action: {
		deleteComment(comment)
	}) {
		Label("삭제", systemImage: "trash")
	}
}

...
```

``.contextMenu()`` 를 사용하여 List 안의 요소들을 삭제하기 위한 버튼을 노출시키는데 사용되고 있다. 
![[context-menu-swiftui.png|300]]

``Section`` 혹은 ``Divider``를 사용하여 각 메뉴별로 구분하는것도 가능하다.
![[context-menu-section.png|300]]

많은 요소들을 커스텀 할 수 있으나, 어디까지나 Apple에서 지정해놓은 **틀** 안에서의 편집이 가능할 뿐 가로 / 세로 길이를 조정한다던가, 정렬 위치의 조정, 기타 여러가지 세부사항들의 구현은 SwiftUI상에서는 불가능하다. 

그래서, 이 부분을 가능하게 해주는 것이 [[UIKit]]이다.

## UIKit
다행히도, 빠른 메뉴는 과거부터 계속 있었기 때문에 UIKit에서도 빠른 메뉴를 지원한다.

```Swift
@MainActor
class UIContextMenuInteraction
```

**UIKit**에서는, 위와 같이 **객체**를 호출함으로서 원하는 요소들을 구현할 수 있다. 

``UIContextMenuInteraction``을 사용하여 빠른 메뉴를 구현할 경우, SwiftUI와 마찬가지로 뒤 화면에 대한 블러가 적용되며, ``UIButton``과 같이 상호작용이 가능한 객체와의 델리게이트를 통해 ``Menu`` 객체를 만들어서 제공해준다.

```Swift
var items: [UIAction] {
    
    let save = UIAction(
        title: "Save",
        image: UIImage(systemName: "plus"),
        handler: { [unowned self] _ in
            self.label.text = "Save"
        })

    let delete = UIAction(
        title: "Delete",
        image: UIImage(systemName: "trash"),
        handler: { [unowned self] _ in
            self.label.text = "Delete"
        })

    let Items = [save, delete]

    return Items
}
```

우선, ``UIAction``을 사용하여 빠른 메뉴에 들어갈 "내용"을 만들어준다.

```Swift
// MARK: - Life Cycles

override func viewDidLoad() {
    super.viewDidLoad()

    let interaction = UIContextMenuInteraction(delegate: self)
    // 버튼의 상호작용을 추가해줍니다.
    button.addInteraction(interaction)
}
```

이후, ``UIContextMenuInteraction``의 대리자를 설정해준다. ``UIContextMenuInteraction``은 iOS 13부터 추가된 기능으로, SwiftUI에서의 ``LongPressGesture``과 같은 기능을 담당한다.

```Swift
extension Way1ViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(actionProvider:  { [unowned self] suggestedActions in
            
            let menu = UIMenu(title: "메뉴1",
                              children: self.items)
     
            return menu
        })
    }
}
```

그 다음으로는, ``UIContextMenuInteraction``의 델리게이트 함수를 정의하여 메뉴를 만들어준다. 

위와 같은 과정으로 만들어진 빠른 메뉴는, 아래와 같이 보여지게 된다.

![[UIKit-ContextMenu.png|300]]
>출처: [Danny의 iOS 컨닝페이퍼](https://ios-daniel-yang.tistory.com/entry/SwiftTIL-15-UIMenu%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%B4%EB%B3%B4%EC%9E%90)

위와 같은 과정으로 생성된 빠른 메뉴는, SwiftUI와 달리 더욱 세부적으로 설정이 가능해진다. 


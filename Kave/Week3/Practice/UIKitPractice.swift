// MARK: UIKit
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
        view.addSubview(button)
    }

    @objc func buttonTapped() {
        print("Button was tapped!")
    }
}

// MARK: UIKit을 SwiftUI에서 사용하기
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyViewController {
        return MyViewController()
    }

    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // No update needed for static preview
    }
}

struct MyViewController_Previews: PreviewProvider {
    static var previews: some View {
        MyViewControllerRepresentable()
            .previewDevice("iPhone 14")
    }
}
#endif

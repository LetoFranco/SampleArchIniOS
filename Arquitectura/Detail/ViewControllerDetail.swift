import Foundation
import UIKit

class ViewControllerDetail: UIViewController {
  
  lazy var fakeNavigationBar: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .primaryColor
    view.height(equalTo: 98)
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
  }
  
  @objc private func onBackBeenPress() {
    navigationController?.popViewController(animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}


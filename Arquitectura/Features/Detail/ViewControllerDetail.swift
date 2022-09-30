import Foundation
import UIKit

class ViewControllerDetail: UIViewController {
  
  lazy var fakeNavigationBar: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.height(equalTo: 98)
    
    return view
  }()
  
  let titleLabel: UILabel = .load {
    $0.textColor = .green
  }
  
  private let viewModel: ItemDetailViewModel
  
  init(_ viewModel: ItemDetailViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  @objc private func onBackBeenPress() {
    navigationController?.popViewController(animated: true)
  }
  
  private func setupView() {
    view.backgroundColor = UIColor.white
    setupStack()
  }
  
  private func setupStack() {}
  
  private func buildItemView() {}
}


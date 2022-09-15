import Foundation
import UIKit

extension UITableViewCell: Reusable {}

extension UITableView {
  
  func dequeue<C: UITableViewCell>(_ cellIdentifier: String = C.reuseID,
                                   for indexPath: IndexPath) -> C {
    guard let cell = dequeueReusableCell(withIdentifier: cellIdentifier,
                                         for: indexPath) as? C
    else { fatalError(
      "\(C.self) is not registed in the Table view for identifier: \(cellIdentifier)"
    ) }
    
    return cell
  }
  
  var dummyHeight: CGFloat { 80 }
}

extension UITableView {
  
  func applyClientStyle() {
    backgroundColor = .systemGray2
    estimatedRowHeight = dummyHeight
    rowHeight = UITableView.automaticDimension
    showsVerticalScrollIndicator = false
    separatorColor = .clear
    separatorStyle = .none
  }
}

import Foundation
import UIKit

protocol GenericTableCellHandler {
  
  static func register(in tableView: UITableView)
  
  func cell(for view: UITableView, at indexPath: IndexPath) -> UITableViewCell
  
}

extension Array where Element == GenericTableCellHandler {
  
  mutating func add(space height: CGFloat) -> Void {
    append(SpaceTableCellHandler(requiredHeight: height, backgroundColor: .clear))
  }
  
}

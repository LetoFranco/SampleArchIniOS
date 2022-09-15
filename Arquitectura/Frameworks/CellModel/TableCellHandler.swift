import Foundation
import UIKit

/// Register Cell and draw presentable data into an UITableViewCell
protocol TableCellHandler: GenericTableCellHandler {
  associatedtype Cell: UITableViewCell
  
  func update(_ cell: Cell)
}

extension TableCellHandler {
  
  static func register(in tableView: UITableView) {
    tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseID)
  }
  
  func cell(for view: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    let cell: Cell = view.dequeue(for: indexPath)
    update(cell)
    
    return cell
  }
}

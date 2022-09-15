import Foundation
import UIKit

struct SpaceTableCellHandler: TableCellHandler {
  typealias Cell = SpaceTableCell
  
  let requiredHeight: CGFloat
  let backgroundColor: UIColor
  
  func update(_ cell: Cell) {
    cell.requiredHeight = requiredHeight
    cell.backgroundColor = backgroundColor
  }
}

class SpaceTableCell: UITableViewCell {
  
  // MARK: - Attributes
  
  private var heightConstraint: NSLayoutConstraint?
  var requiredHeight: CGFloat = 16 {
    didSet {
      refreshConstraints()
    }
  }
  
  // MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - Private Functions
  
  private func setupView() {
    backgroundColor = .clear
    selectionStyle = .none
    let emptyView = UIView.load {
      $0.backgroundColor = .clear
    }
    contentView.addSubview(emptyView)
    heightConstraint = emptyView.heightAnchor.constraint(
      equalToConstant: requiredHeight
    ).activate()
    emptyView.pinToEdges(of: contentView)
  }
  
  private func refreshConstraints() {
    heightConstraint?.constant = requiredHeight
    layoutIfNeeded()
  }
  
}

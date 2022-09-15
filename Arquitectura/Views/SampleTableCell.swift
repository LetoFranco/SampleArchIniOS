import Foundation
import UIKit

struct SampleTableCellHandler: TableCellHandler {
  typealias Cell = SampleTableCell
  
  private let text: String
  
  init(model: String) {
    self.text = model.capitalized
  }
  
  func update(_ cell: Cell) {
    cell.update(title: text)
  }
}

class SampleTableCell: UITableViewCell {
  
  // MARK: - Attributes
  
  private lazy var cardView: UIView = .load {
    $0.backgroundColor = UIColor.white
    $0.setRoundBorders(12)
  }
  
  private lazy var titleLabel: UILabel = .load()
  
  private let insideCardSpacing: UIEdgeInsets = .init(
    top: 16, left: 16, bottom: 24, right: 16
  )
  
  // MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - Public Functions
  
  
  func update(title: String) {
    titleLabel.text = title
    titleLabel.textColor = UIColor.black
  }
  
  // MARK: - Private Functions
  
  private func setupView() {
    backgroundColor = .clear
    selectionStyle = .none
    
    contentView.addSubview(cardView)
    cardView.pinToEdges(of: contentView, with: .init(horizontal: 16, vertical: 24))
    
    cardView.addSubview(titleLabel)
    titleLabel.pinToEdges(of: cardView, with: insideCardSpacing)
  }
}

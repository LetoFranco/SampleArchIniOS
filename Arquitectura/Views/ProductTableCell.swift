import Foundation
import UIKit

struct ProductTableCellHandler: TableCellHandler {
  typealias Cell = ProductTableCell
  
  private let model: Product
  let showDetail: ((Product) -> Void)
  
  init(model: Product, showDetail: @escaping ((Product) -> Void)) {
    self.model = model
    self.showDetail = showDetail
  }
  
  func update(_ cell: Cell) {
    cell.titleLabel.text = model.name
    cell.detailLabel.text = "$ \(model.price)"
    cell.onBeenSelected = { showDetail(model) }
  }
}

class ProductTableCell: UITableViewCell {
  
  // MARK: - Attributes
  
  var onBeenSelected: (() -> Void) = {}
  
  private lazy var cardView: UIView = .load()
  
  lazy var titleLabel: UILabel = .load()
  lazy var detailLabel: UILabel = .load()
  
  private lazy var imageContainer: UIView = .load { view in
    view.addSubviews(productImageView, likeButton)
    view.setRoundBorders(10)
    productImageView.pinToEdges(of: view)
    
    likeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).activate()
    likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).activate()
    likeButton.widthAnchor.constraint(equalToConstant: 44).activate()
    likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor).activate()
    productImageView.width(equalTo: 131)
    productImageView.height(equalTo: 131)
  }
  
  private lazy var stackView: UIStackView = .load {
    $0.addArrangedSubview(titleLabel)
    $0.addArrangedSubview(detailLabel)
    $0.axis = .vertical
    $0.spacing = 4
  }
  
  private lazy var productImageView: UIImageView = .load { view in
    view.backgroundColor = UIColor.gray
  }
  
  private lazy var likeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
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
    contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBeenPressed)))
    
    contentView.addSubview(cardView)
    cardView.addSubviews(imageContainer, stackView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    cardView.pinToEdges(of: contentView, with: .init(horizontal: 16, vertical: 24))
    [
      imageContainer.topAnchor.constraint(equalTo: cardView.topAnchor),
      imageContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
      imageContainer.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 10),
      stackView.topAnchor.constraint(equalTo: cardView.topAnchor),
      stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor)
    ].activate()
  }
  
  @objc private func onBeenPressed() { onBeenSelected() }
}

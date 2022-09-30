import Foundation
import UIKit

protocol MVPView: AnyObject {
  func updateResults(_ results: [Product])
}

class MVPViewController: UIViewController {
  
  // MARK: - Attributes
  
  private let presenter: MVPPresenter
  private var items = [GenericTableCellHandler]()
  
  private lazy var tableView: UITableView = .load {
    $0.dataSource = self
    ProductTableCellHandler.register(in: $0)
  }
  
  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.delegate = self
    
    return searchBar
  }()
  
  // MARK: - Init
  
  init(presenter: MVPPresenter) {
    self.presenter = presenter
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - View
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    refresh()
  }
  
  // MARK: - Private Functions
  
  private func setupView() {
    view.addSubview(tableView)
    tableView.pinToEdges(of: view)
    
    navigationItem.titleView = searchBar
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(onCartBeenPressed))
  }
  
  @objc private func onCartBeenPressed() {
    print("Card has been pressed!")
  }
  
  // MARK: - Service
  
  private func refresh() {
    presenter.callService()
  }
  
  private func showDetail(of product: Product) {
    guard let navigation = navigationController else { return }
    
    ItemDetailCoordinator(navigation: navigation, product: product)
      .start()
  }
}

extension MVPViewController: MVPView {
  
  func updateResults(_ results: [Product]) {
    items = results.map {
      ProductTableCellHandler(model: $0) { [weak self] product in
        self?.showDetail(of: product)
      }
    }
    tableView.reloadData()
  }
}

extension MVPViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    items[indexPath.row].cell(for: tableView, at: indexPath)
  }
}

extension MVPViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print("Text Did Change to:", searchText)
  }
}

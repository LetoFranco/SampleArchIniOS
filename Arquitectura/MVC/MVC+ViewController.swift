import Foundation
import UIKit

class MVCViewController: UIViewController {
  
  // MARK: - Attributes
  
  let fetchService: FetchService
  
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
  
  init(
    fetchService: FetchService
  ) {
    self.fetchService = fetchService
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - View
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    refreshData()
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
  
  private func load(_ newItems: [Product]) {
    items = newItems.map {
      ProductTableCellHandler(model: $0) { [weak self] product in
        self?.showDetail(of: product)
      }
    }
    tableView.reloadData()
  }
  
  private func showDetail(of product: Product) {
    let controller = ViewControllerDetail()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  // MARK: - Service
  
  private func refreshData() {
    fetchService.fetch { [weak self] in
      self?.load($0)
    }
  }
}

extension MVCViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    items[indexPath.row].cell(for: tableView, at: indexPath)
  }
}

extension MVCViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print("Text Did Change to:", searchText)
  }
}

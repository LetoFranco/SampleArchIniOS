import Foundation
import UIKit


class ViewModel {
  let items = DynamicValue([ItemViewModel]())
  
  func fetch() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      DispatchQueue.main.async {
        let models = ["Titulo1", "Titulo2", "Titulo3"]
        // self.items.value = models.map(ItemViewModel.init)
        self.items.value = models.map { ItemViewModel(model: $0) }
      }
    }
    
  }
}

struct ItemViewModel {
  let title: String
  
  init(model: String) {
    self.title = model
  }
}


class MVVMViewController: UIViewController {
  
  // MARK: - Attributes
  
  let viewModel: MVVMConcreteViewModel
  
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
  
  init(viewModel: MVVMConcreteViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - View
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    bindViewModel()
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
  
  private func bindViewModel() {
    viewModel.results.addObserver(self) { [weak self] results in
      self?.load(results)
    }
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
    guard let navigation = navigationController else { return }
    
    ItemDetailCoordinator(navigation: navigation, product: product)
      .start()
  }
  
  // MARK: - Service
  
  func refresh() {
    viewModel.requestItems()
  }
}

extension MVVMViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    items[indexPath.row].cell(for: tableView, at: indexPath)
  }
}

extension MVVMViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print("Text Did Change to:", searchText)
  }
}

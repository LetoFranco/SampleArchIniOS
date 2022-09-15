import Foundation

class MVVMConcreteViewModel {
  
  // MARK: - Attributes
  
  let results = DynamicValue([Product]())
  private let service: FetchService
  
  // MARK: - Init
  
  init(service: FetchService) {
    self.service = service
  }
  
  // MARK: - Internal Functions
  
  func requestItems() {
    service.fetch { [weak self] in
      self?.results.value = $0
    }
  }
}

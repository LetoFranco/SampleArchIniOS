import Foundation

protocol MVPPresenter {
  func callService()
}

class MVPConcretePresenter: MVPPresenter {
  
  // MARK: - Attributes
  
  weak var view: MVPView?
  private let service: FetchService
  
  // MARK: - Init
  
  init(service: FetchService) {
    self.service = service
  }
  
  // MARK: - Internal Functions
  
  func callService() {
    service.fetch { [weak self] in
      self?.view?.updateResults($0)
    }
  }
}

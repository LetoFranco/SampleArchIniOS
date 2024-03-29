import Foundation

class DynamicValue<T> {
  typealias CompletionHandler = ((T) throws -> Void)
  
  var value: T {
    didSet {
      let value = self.value
      DispatchQueue.main.async {
        self.notify(value: value)
      }
    }
  }
  
  private var observers = [String: CompletionHandler]()
  
  init(_ value: T) {
    self.value = value
  }
  
  public func addObserver(_ observer: IdentifiableValue, completionHandler: @escaping CompletionHandler) rethrows {
    observers[observer.identifier] = completionHandler
  }
  
  public func addAndNotify(observer: IdentifiableValue, completionHandler: @escaping CompletionHandler) rethrows {
    try self.addObserver(observer, completionHandler: completionHandler)
    self.notify(value: self.value)
  }
  
  public func removeAllObservers() {
    self.observers.removeAll()
  }
  
  private func notify(value: T) {
    observers.forEach { try? $0.value(value) }
  }
  
  deinit {
    observers.removeAll()
  }
}

protocol IdentifiableValue {
  var identifier: String { get }
}

extension NSObject: IdentifiableValue {
  var identifier: String { description }
}

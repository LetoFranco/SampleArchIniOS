import Foundation
import UIKit
import Combine

protocol NotificationHandler: AnyObject, Listener {
  associatedtype Param
  
  var handlers: [((Param) -> Void)] { get }
  var notificationName: NSNotification.Name { get }
}

protocol Listener {
  func startListen()
  func stopListen()
  func clearAllHandlers()
}

class NotificationObserver<Value>: NotificationHandler {
  typealias Param = Value
  
  var handlers = [(Value) -> Void]()
  let notificationName: NSNotification.Name
  
  init(for notificationName: NSNotification.Name) {
    self.notificationName = notificationName
  }
  
  func startListen() {
    stopListen()
    NotificationCenter.default.addObserver(self, selector: #selector(receive), name: notificationName, object: nil)
  }
  
  func stopListen() {
    NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
  }
  
  func clearAllHandlers() { handlers.removeAll() }
  
  deinit { stopListen() }
  
  @objc func receive(notification: NSNotification) {
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      if let value = () as? Param {
        self.callHandlers(with: value)
        
        return
      }
      
      guard let anyValue = notification.object else { return }
      guard let value = anyValue as? Param else { return }
      
      self.callHandlers(with: value)
    }
  }
  
  private func callHandlers(with value: Value) { handlers.forEach { $0(value) } }
  
}

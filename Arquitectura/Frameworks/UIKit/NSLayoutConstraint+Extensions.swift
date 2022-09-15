import Foundation
import UIKit

extension NSLayoutConstraint {
  
  @discardableResult func withPriority(_ value: UILayoutPriority) -> NSLayoutConstraint {
    priority = value
    
    return self
  }
  @discardableResult func activate() -> NSLayoutConstraint { change(isActive: true) }
  @discardableResult func deactivate() -> NSLayoutConstraint { change(isActive: false) }
  
  @discardableResult private func change(isActive: Bool) -> NSLayoutConstraint {
    self.isActive = isActive
    
    return self
  }
}

extension Array where Element == NSLayoutConstraint {
  
  @discardableResult
  func activate() -> Self { map { $0.activate() } }
  
  @discardableResult
  func deactivate() -> Self { map { $0.deactivate() } }
  
}

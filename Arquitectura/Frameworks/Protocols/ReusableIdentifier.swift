import Foundation

internal protocol Reusable {
  
  static var reuseID: String { get }
  
}

extension Reusable {
  
  static var reuseID: String {
    String(describing: Self.self)
  }
  
}

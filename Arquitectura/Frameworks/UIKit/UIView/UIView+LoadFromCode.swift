import Foundation
import UIKit

extension UIView {
  
  class public func load<View: UIView>(
    _ callback: ((View) -> Void) = { _ in }
  ) -> View {
    let view = View()
    view.translatesAutoresizingMaskIntoConstraints = false
    callback(view)
    
    return view
  }
}

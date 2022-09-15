import Foundation
import UIKit

extension UIEdgeInsets {
  
  init(squared: CGFloat) {
    self.init(
      top: squared, left: squared, bottom: squared, right: squared
    )
  }
  
  init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
    self.init(
      top: vertical, left: horizontal, bottom: vertical, right: horizontal
    )
  }
  
}

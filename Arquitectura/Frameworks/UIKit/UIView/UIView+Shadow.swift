import Foundation
import UIKit

extension UIView {
  
  func removeShadow() {
    layer.shadowColor = UIColor.clear.cgColor
  }
  
  func drawShadow(opacity: Float = 1.0) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
    layer.shadowRadius = 4
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowOpacity = opacity
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
  }
}

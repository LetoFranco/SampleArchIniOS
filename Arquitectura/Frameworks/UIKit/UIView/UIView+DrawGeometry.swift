import Foundation
import UIKit

extension UIView {
  
  func buildCircle(
    startAngle: CGFloat,
    endAngle: CGFloat,
    radius: CGFloat,
    center: CGPoint
  ) -> UIBezierPath {
    UIBezierPath(
      arcCenter: center,
      radius: radius,
      startAngle: startAngle * (Double.pi * 2) / 360.0,
      endAngle: endAngle * (Double.pi * 2) / 360.0,
      clockwise: true
    )
  }
  
  @discardableResult func drawCircle(
    circlePath: UIBezierPath,
    borderColor: UIColor,
    fillColor: UIColor = .clear,
    lineWidth: CGFloat
  ) -> CAShapeLayer {
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    
    shapeLayer.fillColor = fillColor.cgColor
    shapeLayer.strokeColor = borderColor.cgColor
    shapeLayer.lineWidth = lineWidth
    DispatchQueue.main.async{
      self.layer.addSublayer(shapeLayer)
      shapeLayer.zPosition = -1
    }
    
    return shapeLayer
  }
  
  @discardableResult func drawLine(
    startPosition: CGPoint,
    endPosition: CGPoint,
    color: UIColor,
    lineWidth: CGFloat
  ) -> CAShapeLayer {
    
    let linePath = UIBezierPath(
      rect: CGRect(
        origin: startPosition,
        size: CGSize(width: endPosition.x - startPosition.x , height: 1)
      )
    )
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = linePath.cgPath
    
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = lineWidth
    DispatchQueue.main.async{
      self.layer.addSublayer(shapeLayer)
      shapeLayer.zPosition = -2
    }
    return shapeLayer
  }
}


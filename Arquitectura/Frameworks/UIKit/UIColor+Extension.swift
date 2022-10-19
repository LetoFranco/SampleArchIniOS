//
//  UIColor+Extension.swift
//  Arquitectura
//
//  Created by Franco Leto on 30/09/2022.
//

import Foundation
import UIKit

extension UIColor {
  
  static var randomColor: UIColor {
    UIColor(red: randomValue, green: randomValue, blue: randomValue, alpha: 1.0)
  }
  
  private static var randomValue: CGFloat {
    CGFloat.random(in: 0...1)
  }
}

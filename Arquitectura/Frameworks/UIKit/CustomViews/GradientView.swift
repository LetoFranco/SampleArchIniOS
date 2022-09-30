//
//  GradientView.swift
//  Arquitectura
//
//  Created by Franco Leto on 30/09/2022.
//

import Foundation
import UIKit

struct Gradient {
  struct Mode {
    let start: CGPoint
    let end: CGPoint
    
    static var vertical: Self {
      .init(start: .init(x: 0.5, y: 0), end: .init(x: 0.5, y: 1))
    }
  }
  
  // MARK: - Attributes
  
  let mode: Mode
  let colors: [UIColor]
  let locations: [Double]
  let distribution: CAGradientLayerType
  
  // MARK: - Internal Functions
  
  func createLayer() -> CAGradientLayer {
    let layer = CAGradientLayer()
    
    update(layer)
    
    return layer
  }
  
  func update(_ layer: CAGradientLayer) {
    layer.startPoint = mode.start
    layer.endPoint = mode.end
    layer.colors = colors.map { $0.cgColor }
    layer.locations = locations.map { $0 as NSNumber }
    layer.type = distribution
  }
}

class GradientView: UIView {
  
  // MARK: - Attributes
  
  override public class var layerClass: AnyClass {
    CAGradientLayer.self
  }
  
  var gradient = Gradient(
    mode: .vertical, colors: [], locations: [], distribution: .axial
  ) {
    didSet { refresh() }
  }
  
  private var gradientLayer: CAGradientLayer? {
    layer as? CAGradientLayer
  }
  
  // MARK: - View
  
  override public func traitCollectionDidChange(
    _ previousTraitCollection: UITraitCollection?
  ) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    refresh()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    refresh()
  }
  
  // MARK: - Internal Functions
  
  func refresh() {
    guard let gradientLayer = gradientLayer else { return }
    
    gradient.update(gradientLayer)
  }
}

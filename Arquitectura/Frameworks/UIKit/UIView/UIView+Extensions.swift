import Foundation
import UIKit

extension UIView {
  
  // MARK: - Static Functions
  
  class public func divider(
    color: UIColor,
    isVertical: Bool,
    constant: CGFloat = 1
  ) -> UIView {
    .load {
      $0.backgroundColor = color
      (isVertical ? $0.heightAnchor : $0.widthAnchor)
        .constraint(equalToConstant: constant)
        .activate()
    }
  }
  
  // MARK: - Internal Functions
  
  func addSubviews(_ subviews: UIView...) { subviews.forEach { addSubview($0) } }
  func addSubviews(_ subviews: [UIView]) { subviews.forEach { addSubview($0) } }
  
  /// Creates a Container with a specific padding to it.
  func createContainer(with padding: UIEdgeInsets = .zero) -> UIView {
    .load {
      $0.addSubview(self)
      $0.backgroundColor = .clear
      pinToEdges(of: $0, with: padding)
    }
  }
  
  /// Pin to edges of a superview.
  func pinToEdges(of superView: UIView, with padding: UIEdgeInsets = .zero) {
    [
      topAnchor.constraint(
        equalTo: superView.topAnchor, constant: padding.top
      ),
      leadingAnchor.constraint(
        equalTo: superView.leadingAnchor, constant: padding.left
      ),
      trailingAnchor.constraint(
        equalTo: superView.trailingAnchor, constant: -padding.right
      ),
      bottomAnchor.constraint(
        equalTo: superView.bottomAnchor, constant: -padding.bottom
      )
    ].activate()
  }
  
  func addAndSetConstraints(with axis: NSLayoutConstraint.Axis, for views: [UIView]) {
    guard views.count > 0 else { return }

    var previousView: UIView? = nil
    for view in views {
      addSubview(view)
      switch axis {
      case .vertical:
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? safeTop).isActive = true
      case .horizontal:
        view.topAnchor.constraint(equalTo: safeTop).isActive = true
        view.bottomAnchor.constraint(equalTo: safeBottom).isActive = true
        view.leadingAnchor.constraint(equalTo: previousView?.trailingAnchor ?? leadingAnchor).isActive = true
      @unknown default: break
      }
      previousView = view
    }
    
    switch axis {
    case .vertical:
      previousView?.bottomAnchor.constraint(equalTo: safeBottom).isActive = true
    case .horizontal:
      previousView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    @unknown default: break
    }
  }
  
  @discardableResult
  func height(equalTo const: CGFloat) -> Self {
    heightAnchor.constraint(equalToConstant: const).activate()
    
    return self
  }
  
  @discardableResult
  func width(equalTo const: CGFloat) -> Self {
    widthAnchor.constraint(equalToConstant: const).activate()
    
    return self
  }
  
  @discardableResult
  func squareAspect() -> Self {
    heightAnchor.constraint(equalTo: widthAnchor).activate()
    
    return self
  }
  
  // MARK: - Layout
  
  var safeTop: NSLayoutYAxisAnchor { safeAreaLayoutGuide.topAnchor }
  var safeLeading: NSLayoutXAxisAnchor { safeAreaLayoutGuide.leadingAnchor }
  var safeTrailling: NSLayoutXAxisAnchor { safeAreaLayoutGuide.trailingAnchor }
  var safeBottom: NSLayoutYAxisAnchor { safeAreaLayoutGuide.bottomAnchor }
  
  var readableTop: NSLayoutYAxisAnchor { readableContentGuide.topAnchor }
  var readableLeading: NSLayoutXAxisAnchor { readableContentGuide.leadingAnchor }
  var readableTrailling: NSLayoutXAxisAnchor { readableContentGuide.trailingAnchor }
  var readableBottom: NSLayoutYAxisAnchor { readableContentGuide.bottomAnchor }
  
}

extension UIView {
  
  // MARK: - Instance methods
  
  // Change the default values for params as you wish
  func addBorder(color: UIColor = UIColor.lightText, weight: CGFloat = 1.0) {
    layer.borderColor = color.cgColor
    layer.borderWidth = weight
  }
  
  func setRoundBorders(_ cornerRadius: CGFloat = 10.0) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
  }
  
  var typeName: String {
    String(describing: type(of: self))
  }
  
  func animateChangeInLayout(withDuration duration: TimeInterval = 0.2) {
    setNeedsLayout()
    UIView.animate(withDuration: duration, animations: { [weak self] in
      self?.layoutIfNeeded()
    })
  }
}

extension Array where Element: UIView {
  func addBorder(color: UIColor = UIColor.lightText, weight: CGFloat = 1.0) {
    forEach { $0.addBorder(color: color, weight: weight) }
  }
  
  func roundBorders(cornerRadius: CGFloat = 10.0) {
    forEach { $0.setRoundBorders(cornerRadius) }
  }
}

//
//  ScrollableStackView.swift
//  Arquitectura
//
//  Created by Franco Leto on 21/09/2022.
//

import Foundation
import UIKit

class ScrollableStackView: UIView {
  
  // MARK: - Attributes
  
  lazy var scrollView: UIScrollView = .load {
    $0.showsHorizontalScrollIndicator = false
    $0.clipsToBounds = false
  }
  
  var axis: NSLayoutConstraint.Axis {
    get { stackView.axis }
    set {
      stackView.axis = newValue
      refreshConstraints()
    }
  }
  
  private (set) lazy var stackView: UIStackView = .load {
    $0.spacing = 0.0
  }
  
  private var heightConstraint: NSLayoutConstraint?
  private var widthConstraint: NSLayoutConstraint?
  
  var spacing: CGFloat {
    get { stackView.spacing }
    set { stackView.spacing = newValue }
  }
  
  // MARK: - Init
  
  init() {
    super.init(frame: .zero)
    
    setupView()
    showsScrollIndicator(isVisible: false)
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - Internal functions
  
  func scrollToTop() {
    let topOffset = CGPoint(x: 0.0, y: -scrollView.contentInset.top)
    scrollView.setContentOffset(topOffset, animated: true)
  }
  
  func scroll(to view: UIView) {
    scrollView.scroll(to: view, axis: axis)
  }
  
  func scroll(toNextOf view: UIView) {
    guard
      let currentIndex = stackView.arrangedSubviews.firstIndex(of: view),
      let nextView = stackView.arrangedSubviews[safe: currentIndex + 1]
    else { return }
    
    scrollView.scroll(to: nextView, axis: axis)
  }
  
  func setupSubviews(_ views: [UIView]) {
    guard stackView.arrangedSubviews.isEmpty else { return }
    
    loadAndRefresh(views)
  }
  
  func replaceViews(_ views: [UIView]) {
    stackView.removeAllArrangedSubviews()
    loadAndRefresh(views)
  }
  
  func removeLast() { stackView.arrangedSubviews.last?.removeFromSuperview() }
  
  func addNewSubview(_ view: UIView) {
    stackView.addArrangedSubview(view)
    superview?.layoutIfNeeded()
  }
  
  func showsScrollIndicator(isVisible: Bool = true) {
    scrollView.showsVerticalScrollIndicator = isVisible
    scrollView.showsHorizontalScrollIndicator = isVisible
  }
  
  // MARK: - Private Functions
  
  private func loadAndRefresh(_ views: [UIView]) {
    stackView.addArrangedSubviews(views)
    superview?.layoutIfNeeded()
  }
  
  private func setupView() {
    addSubview(scrollView)
    scrollView.pinToEdges(of: self)
    scrollView.addSubview(stackView)
    stackView.pinToEdges(of: scrollView)
    heightConstraint = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    widthConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
  }
  
  private func refreshConstraints() {
    heightConstraint?.isActive = axis == .horizontal
    widthConstraint?.isActive = axis == .vertical
  }
}

extension UIScrollView {
  
  func scroll(
    to view: UIView,
    axis: NSLayoutConstraint.Axis,
    animated: Bool = true
  ) {
    guard let parentView = view.superview else { return }
    
    let childStartPoint = parentView.convert(view.frame.origin, to: self)
    let newX = axis == .horizontal ? childStartPoint.x : 0.0
    let newY = axis == .vertical ? childStartPoint.y : 0.0
    
    scrollRectToVisible(
      CGRect(x: newX, y: newY, width: view.frame.width, height: view.frame.height),
      animated: animated
    )
  }
  
}

extension UIStackView {
  
  // MARK: - Internal Functions
  
  func addArrangedSubviews(_ subviews: UIView...) {
    subviews.forEach { addArrangedSubview($0) }
  }
  
  func addArrangedSubviews(_ subviews: [UIView]) {
    subviews.forEach { addArrangedSubview($0) }
  }
  
  func subviews<Casted: UIView>() -> [Casted] {
    arrangedSubviews.compactMap { $0 as? Casted }
  }
  
  private func remove(view: UIView) {
    removeArrangedSubview(view)
    view.removeFromSuperview()
  }
  
  func removeAllArrangedSubviews() {
    arrangedSubviews.forEach { remove(view: $0) }
  }
  
}

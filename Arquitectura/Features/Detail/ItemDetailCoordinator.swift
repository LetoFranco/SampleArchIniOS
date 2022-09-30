//
//  ItemDetailCoordinator.swift
//  Arquitectura
//
//  Created by Franco Leto on 30/09/2022.
//

import Foundation
import UIKit

struct ItemDetailCoordinator: Coordinator {
  let navigation: UINavigationController
  let product: Product
  
  func start() {
    let viewModel = ItemDetailViewModel(product)
    let controller = ViewControllerDetail(viewModel)
    
    controller.view?.backgroundColor = .white
    controller.titleLabel.text = product.name
    
    navigation.pushViewController(controller, animated: true)
  }
}


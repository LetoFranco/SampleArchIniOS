import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  fileprivate let architecture: Architecture = .mvc
  
  fileprivate enum Architecture {
    case mvc, mvp, mvvm
  }
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowsScene = scene as? UIWindowScene else { return }
    
    //setupUserDefaults()
    let window = UIWindow(windowScene: windowsScene)
    window.makeKeyAndVisible()
    self.window = window
    
    switch architecture {
    case .mvc: startMVC()
    case .mvp: startMVP()
    case .mvvm: startMVVM()
    }
  }
  
  /* MVC */
  func startMVC() {
    let service = MockFetchService()
    let controller = MVCViewController(fetchService: service)
    
    self.addAsRoot(controller)
    controller.showProduct = { [weak controller] product in
      guard let controller = controller else { return }
      guard let navigation = controller.navigationController else { return }
      
      ItemDetailCoordinator(navigation: navigation, product: product)
        .start()
    }
  }
  
  /* MVP */
  func startMVP() {
    let service = MockFetchService()
    let presenter = MVPConcretePresenter(service: service)
    let controller = MVPViewController(presenter: presenter)
    presenter.view = controller
    
    self.addAsRoot(controller)
  }
  
  
  /* MVVM */
  func startMVVM() {
    let service = MockFetchService()
    let viewModel = MVVMConcreteViewModel(service: service)
    let controller = MVVMViewController(viewModel: viewModel)
    
    self.addAsRoot(controller)
  }
  
  private func addAsRoot(_ controller: UIViewController) {
    let navigation = UINavigationController(rootViewController: controller)
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
    navBarAppearance.backgroundColor = UIColor.systemYellow
    
    let appearance = UINavigationBar.appearance()
    appearance.standardAppearance = navBarAppearance
    appearance.compactAppearance = navBarAppearance
    appearance.scrollEdgeAppearance = navBarAppearance
    if #available(iOS 15.0, *) {
      appearance.compactScrollEdgeAppearance = navBarAppearance
    } else {
      // Fallback on earlier versions
    }
    window?.rootViewController = navigation
  }
}

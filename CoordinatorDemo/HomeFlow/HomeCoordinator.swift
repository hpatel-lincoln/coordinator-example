// Created by Hardik Patel on 9/4/21.

import UIKit

class HomeCoordinator: NavigationCoordinator {
  
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
  init(router: Router) {
    self.hasStarted = false
    self.coordinator = nil
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted {
      router.dismissModule(animated: false, completion: nil)
      router.popToRootModule(animated: false)
      coordinator = nil
    } else {
      showHome()
    }
    
    if let deepLink = link {
      handleDeepLink(deepLink)
    }
  }
  
  private func handleDeepLink(_ link: DeepLink) {
    var deepLink = link
    if deepLink.count > 0 {
      let next = deepLink.removeFirst()
      switch next {
      case .push:
        print("push a controller")
      case .pushFlow:
        print("start a push flow")
      default:
        break
      }
    }
  }
  
  private func showHome() {
    let homeController: HomeViewController = .instantiate(from: .home)
    router.setRootModule(homeController)
  }
}

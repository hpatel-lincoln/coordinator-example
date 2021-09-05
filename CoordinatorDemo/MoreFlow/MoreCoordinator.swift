// Created by Hardik Patel on 9/4/21.

import Foundation

class MoreCoordinator: NavigationCoordinator {
  
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
      showMore()
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
      case .about:
        print("push a controller")
      default:
        break
      }
    }
  }
  
  private func showMore() {
    let moreController: MoreViewController = .instantiate(from: .more)
    router.setRootModule(moreController)
  }
}

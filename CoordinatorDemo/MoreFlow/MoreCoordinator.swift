// Created by Hardik Patel on 9/4/21.

import Foundation

class MoreCoordinator: NavigationCoordinator {
  
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
  var didCompleteFlow: (() -> Void)?
  
  init(router: Router) {
    self.hasStarted = false
    self.coordinator = nil
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted == false {
      showMore()
      hasStarted = true
    }
    handleDeepLink(link)
  }
  
  private func handleDeepLink(_ link: DeepLink?) {
    switch link {
    case .about:
      reset()
      showAbout()
    default:
      break
    }
  }
  
  private func reset() {
    router.dismissController(animated: false, completion: nil)
    router.popToRootController(animated: false)
    coordinator = nil
  }
  
  private func showMore() {
    let moreController: MoreViewController = .instantiate(from: .more)
    moreController.didTapAbout = { [unowned self] in
      self.showAbout()
    }
    moreController.didTapLogout = didCompleteFlow
    router.setRootController(moreController)
  }
  
  private func showAbout() {
    let aboutController: AboutViewController = .instantiate(from: .more)
    router.push(aboutController)
  }
}

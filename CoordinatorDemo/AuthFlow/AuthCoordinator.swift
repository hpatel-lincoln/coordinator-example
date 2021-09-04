// Created by Hardik Patel on 9/4/21.

import UIKit

class AuthCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
  var finishFlow: (() -> Void)?
  
  init(router: Router) {
    self.hasStarted = false
    self.coordinator = nil
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted {
      router.dismissModule()
      router.popToRootModule(animated: false)
      coordinator = nil
    } else {
      showLogin()
    }
    
    if let deepLink = link {
      handleDeepLink(deepLink)
    }
  }
  
  private func handleDeepLink(_ link: DeepLink) {
    
  }
  
  private func showLogin() {
    let loginController = UIViewController()
    loginController.view.backgroundColor = .red
    router.setRootModule(loginController)
  }
  
  private func showSignup() {
    let signupController = UIViewController()
    signupController.view.backgroundColor = .green
    router.push(signupController)
  }
}

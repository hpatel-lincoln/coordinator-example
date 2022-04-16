// Created by Hardik Patel on 9/4/21.

import Foundation

class AuthCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool = false
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
  var didCompleteFlow: (() -> Void)?
  
  init(router: Router) {
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted == false {
      showLogin()
      hasStarted = true
    }
    handleDeepLink(link)
  }
  
  private func handleDeepLink(_ link: DeepLink?) {
    switch link {
    case .signup:
      reset()
      showSignup()
    default:
      break
    }
  }
  
  private func reset() {
    router.dismissController(animated: false, completion: nil)
    router.popToRootController(animated: false)
    coordinator = nil
  }
  
  private func showLogin() {
    let loginController: LoginViewController = .instantiate(from: .auth)
    loginController.didCompleteLogin = didCompleteFlow
    loginController.didTapSignup = { [unowned self] in
      self.showSignup()
    }
    router.setRootController(loginController)
  }
  
  private func showSignup() {
    let signupController: SignupViewController = .instantiate(from: .auth)
    signupController.didCompleteSignup = didCompleteFlow
    router.push(signupController)
  }
}

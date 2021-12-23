// Created by Hardik Patel on 9/4/21.

import Foundation

class AuthCoordinator: NavigationCoordinator {
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
      showLogin()
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
    router.dismissModule(animated: false, completion: nil)
    router.popToRootModule(animated: false)
    coordinator = nil
  }
  
  private func showLogin() {
    let loginController: LoginViewController = .instantiate(from: .auth)
    loginController.didCompleteLogin = didCompleteFlow
    loginController.didTapSignup = { [unowned self] in
      self.showSignup()
    }
    router.setRootModule(loginController)
  }
  
  private func showSignup() {
    let signupController: SignupViewController = .instantiate(from: .auth)
    signupController.didCompleteSignup = didCompleteFlow
    router.push(signupController)
  }
}

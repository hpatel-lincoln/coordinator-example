// Created by Hardik Patel on 9/4/21.

import Foundation

class AppCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  private var isAuthorized: Bool = false
  
  init(router: Router) {
    self.hasStarted = false
    self.coordinator = nil
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted {
      coordinator?.start(with: link)
    } else {
      if isAuthorized {
        startMainFlow(with: link)
      } else {
        startAuthFlow(with: link)
      }
    }
  }
  
  private func startMainFlow(with link: DeepLink?) {
    
  }
  
  private func startAuthFlow(with link: DeepLink?) {
    let authCoordinator = AuthCoordinator(router: router)
    authCoordinator.didCompleteFlow = { [unowned self] in
      self.coordinator = nil
      self.isAuthorized = true
      self.start(with: link)
    }
    self.coordinator = authCoordinator
    self.coordinator?.start(with: nil)
  }
}

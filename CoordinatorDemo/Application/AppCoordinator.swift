// Created by Hardik Patel on 9/4/21.

import Foundation

class AppCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
  init(router: Router) {
    self.hasStarted = false
    self.coordinator = nil
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    
  }
}

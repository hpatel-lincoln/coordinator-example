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
        self.hasStarted = true
      } else {
        startAuthFlow(with: link)
        self.hasStarted = true
      }
    }
  }
  
  private func startMainFlow(with link: DeepLink?) {
    let mainController: TabBarController = .instantiate(from: .main)
    let mainCoordinator = MainCoordinator(tabBarController: mainController)
    mainCoordinator.didCompleteFlow = { [unowned self] in
      self.hasStarted = false
      self.coordinator = nil
      self.isAuthorized = false
      self.start(with: nil)
    }
    self.coordinator = mainCoordinator
    router.setRootModule(mainController, hideBar: true)
    self.coordinator?.start(with: link)
  }
  
  private func startAuthFlow(with link: DeepLink?) {
    let authCoordinator = AuthCoordinator(router: router)
    authCoordinator.didCompleteFlow = { [unowned self] in
      self.hasStarted = false
      self.coordinator = nil
      self.isAuthorized = true
      self.start(with: link)
    }
    self.coordinator = authCoordinator
    self.coordinator?.start(with: link)
  }
}

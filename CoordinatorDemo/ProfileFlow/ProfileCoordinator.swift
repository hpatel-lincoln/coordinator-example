// Created by Hardik Patel on 12/20/21.

import Foundation

class ProfileCoordinator: NavigationCoordinator {
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
    if hasStarted {
      router.dismissModule(animated: false, completion: nil)
      router.popToRootModule(animated: false)
      coordinator = nil
    } else {
      showProfile()
    }
  }
  
  private func showProfile() {
    let profileController: ProfileViewController = .instantiate(from: .profile)
    profileController.didTapProfileDetail = { [unowned self] in
      self.showProfileDetail()
    }
    router.push(profileController, animated: true, completion: didCompleteFlow)
  }
  
  private func showProfileDetail() {
    let profileDetailController: ProfileDetailViewController = .instantiate(from: .profile)
    router.push(profileDetailController)
  }
}

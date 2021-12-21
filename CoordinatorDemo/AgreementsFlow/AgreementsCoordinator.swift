// Created by Hardik Patel on 12/21/21.

import Foundation
import UIKit

class AgreementsCoordinator: NavigationCoordinator {
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
      showController()
    }
  }
  
  private func showController() {
    let controller = UIViewController()
    controller.view.backgroundColor = UIColor.green
    router.setRootModule(controller)
  }
}

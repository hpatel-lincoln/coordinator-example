// Created by Hardik Patel on 12/21/21.

import Foundation
import UIKit

class AgreementsCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool = false
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
  var didCompleteFlow: ((Bool) -> Void)?
  
  init(router: Router) {
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted == false {
      showAgreementsController()
      hasStarted = true
    }
  }
  
  private func showAgreementsController() {
    let agreementsController: AgreementsViewController = .instantiate(from: .agreements)
    agreementsController.didTapNext = { [unowned self] in
      self.showAcceptAgreementsController()
    }
    router.setRootController(agreementsController)
  }
  
  private func showAcceptAgreementsController() {
    let acceptAgreementsController: AcceptAgreementsViewController = .instantiate(from: .agreements)
    acceptAgreementsController.didTapAccept = didCompleteFlow
    acceptAgreementsController.didTapDecline = didCompleteFlow
    router.push(acceptAgreementsController)
  }
}

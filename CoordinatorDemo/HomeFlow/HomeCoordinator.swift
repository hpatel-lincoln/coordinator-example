// Created by Hardik Patel on 9/4/21.

import UIKit

class HomeCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool = false
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  private var homeController: HomeViewController?
  
  init(router: Router) {
    self.router = router
  }
  
  func start(with link: DeepLink?) {
    if hasStarted == false {
      showHome()
      hasStarted = true
    }
    handleDeepLink(link)
  }
  
  private func handleDeepLink(_ link: DeepLink?) {
    switch link {
    case .profile:
      reset()
      startProfileFlow(with: link)
    case .agreements:
      reset()
      startAgreementsFlow(with: link)
    default:
      break
    }
  }
  
  private func reset() {
    router.dismissController(animated: false, completion: nil)
    router.popToRootController(animated: false)
    coordinator = nil
  }
  
  private func showHome() {
    let homeController: HomeViewController = .instantiate(from: .home)
    homeController.didTapViewProfile = { [unowned self] in
      self.startProfileFlow(with: nil)
    }
    homeController.didTapShowAgreements = { [unowned self] in
      self.startAgreementsFlow(with: nil)
    }
    self.homeController = homeController
    self.router.setRootController(homeController)
  }
  
  private func startProfileFlow(with link: DeepLink?) {
    let profileCoordinator = ProfileCoordinator(router: router)
    profileCoordinator.didCompleteFlow = { [unowned self] in
      self.coordinator = nil
    }
    self.coordinator = profileCoordinator
    self.coordinator?.start(with: link)
  }
  
  private func startAgreementsFlow(with link: DeepLink?) {
    let navigationController = UINavigationController()
    let agreementsRouter = RouterImp(rootController: navigationController)
    let agreementsCoordinator = AgreementsCoordinator(router: agreementsRouter)
    agreementsCoordinator.didCompleteFlow = { [unowned self] accepted in
      self.coordinator = nil
      self.router.dismissController()
      self.homeController?.onAcceptAgreements(accepted)
    }
    self.coordinator = agreementsCoordinator
    self.router.present(navigationController, animated: true) { [unowned self] in
      coordinator = nil
    }
    self.coordinator?.start(with: link)
  }
}

extension HomeCoordinator: PresentingCoordinator {
  
  func dismiss() {
    if coordinator is AgreementsCoordinator {
      coordinator = nil
    }
  }
}

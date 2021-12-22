// Created by Hardik Patel on 9/4/21.

import UIKit

class HomeCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  private var homeController: HomeViewController?
  
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
      showHome()
    }
    
    if let deepLink = link {
      handleDeepLink(deepLink)
    }
  }
  
  private func handleDeepLink(_ link: DeepLink) {
    switch link {
    case .profile:
      startProfileFlow(with: link)
    case .agreements:
      startAgreementsFlow(with: link)
    default:
      break
    }
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
    self.router.setRootModule(homeController)
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
    navigationController.modalPresentationStyle = .fullScreen
    router.present(navigationController)
    
    let agreementsRouter = RouterImp(rootController: navigationController)
    let agreementsCoordinator = AgreementsCoordinator(router: agreementsRouter)
    agreementsCoordinator.didCompleteFlow = { [unowned self] accepted in
      self.coordinator = nil
      self.router.dismissModule()
      self.homeController?.onAcceptAgreements(accepted)
    }
    self.coordinator = agreementsCoordinator
    self.coordinator?.start(with: link)
  }
}

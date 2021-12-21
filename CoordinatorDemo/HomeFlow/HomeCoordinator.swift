// Created by Hardik Patel on 9/4/21.

import UIKit

class HomeCoordinator: NavigationCoordinator {
  private(set) var hasStarted: Bool
  private(set) var coordinator: Coordinator?
  private(set) var router: Router
  
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
    var deepLink = link
    if deepLink.count > 0 {
      let next = deepLink.removeFirst()
      switch next {
      case .profile:
        startProfileFlow(with: deepLink)
      case .agreements:
        startAgreementsFlow(with: deepLink)
      default:
        break
      }
    }
  }
  
  private func showHome() {
    let homeController: HomeViewController = .instantiate(from: .home)
    homeController.didTapProfileFlow = { [unowned self] in
      self.startProfileFlow(with: nil)
    }
    router.setRootModule(homeController)
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
    let agreementsRouter = RouterImp(rootController: navigationController)
    
    let agreementsCoordinator = AgreementsCoordinator(router: agreementsRouter)
    self.coordinator = agreementsCoordinator
    router.present(navigationController)
    self.coordinator?.start(with: link)
  }
}

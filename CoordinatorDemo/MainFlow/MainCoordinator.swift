// Created by Hardik Patel on 9/4/21.

import UIKit

class MainCoordinator: TabBarCoordinator {
  private(set) var coordinators: [Int : Coordinator] = [:]
  private(set) var tabBarController: TabBarController
  
  var didCompleteFlow: (() -> Void)?
  
  init(tabBarController: TabBarController) {
    self.tabBarController = tabBarController
  }
  
  func start(with link: DeepLink?) {
    if coordinators.isEmpty {
      setup()
      selectIndex(0, with: nil)
    }
    handleDeepLink(link)
  }
  
  private func setup() {
    guard
      let viewControllers = tabBarController.viewControllers
    else { return }
    
    for index in viewControllers.indices {
      setCoordinatorForIndex(index)
    }
    
    tabBarController.didSelectIndex = { [unowned self] index in
      selectIndex(index, with: nil)
    }
  }
  
  private func setCoordinatorForIndex(_ index: Int) {
    guard
      let viewcontrollers = tabBarController.viewControllers,
      index >= 0,
      index < viewcontrollers.count,
      let navController = viewcontrollers[index] as? UINavigationController
    else { return }
    
    let router = RouterImp(rootController: navController)
    
    switch index {
    case 0:
      let homeCoordinator = HomeCoordinator(router: router)
      coordinators[0] = homeCoordinator
    case 1:
      let moreCoordinator = MoreCoordinator(router: router)
      moreCoordinator.didCompleteFlow = didCompleteFlow
      coordinators[1] = moreCoordinator
    default:
      break
    }
  }
  
  private func handleDeepLink(_ link: DeepLink?) {
    switch link {
    case .home, .profile, .agreements:
      releasePresentedCoordinator()
      selectIndex(0, with: link)
    case .more, .about:
      releasePresentedCoordinator()
      selectIndex(1, with: link)
    default:
      break
    }
  }
  
  private func selectIndex(_ index: Int, with link: DeepLink?) {
    guard
      let viewControllers = tabBarController.viewControllers,
      index >= 0,
      index < viewControllers.count
    else { return }
    
    tabBarController.selectedIndex = index
    let coordinator = coordinators[index]
    coordinator?.start(with: link)
  }
  
  private func releasePresentedCoordinator() {
    let selectedIndex = tabBarController.selectedIndex
    if selectedIndex >= 0,
       let presentingCoordinator = coordinators[selectedIndex] as? PresentingCoordinator {
      presentingCoordinator.dismiss()
    }
  }
}

// Created by Hardik Patel on 9/4/21.

import UIKit

protocol Router {
  
  func setRootModule(_ module: Presentable)
  func setRootModule(_ module: Presentable, hideBar: Bool)
  
  func present(_ module: Presentable)
  func present(_ module: Presentable, animated: Bool)
  
  func dismissModule()
  func dismissModule(animated: Bool, completion: (() -> Void)?)
  
  func push(_ module: Presentable)
  func push(_ module: Presentable, animated: Bool)
  func push(_ module: Presentable, hideBottomBar: Bool)
  func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
  func push(_ module: Presentable, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
  
  func popModule()
  func popModule(animated: Bool)
  
  func popToRootModule(animated: Bool)
}

final class RouterImp: NSObject, Router {
  
  private var rootController: UINavigationController
  private var completions: [UIViewController : () -> Void]
  
  init(rootController: UINavigationController) {
    self.rootController = rootController
    completions = [:]
    super.init()
    self.rootController.delegate = self
  }
  
  func setRootModule(_ module: Presentable) {
    setRootModule(module, hideBar: false)
  }
  
  func setRootModule(_ module: Presentable, hideBar: Bool) {
    let controller = module.toPresent()
    rootController.setViewControllers([controller], animated: false)
    rootController.isNavigationBarHidden = hideBar
  }
  
  func present(_ module: Presentable) {
    present(module, animated: true)
  }
  
  func present(_ module: Presentable, animated: Bool) {
    let controller = module.toPresent()
    rootController.present(controller, animated: animated, completion: nil)
  }
  
  func dismissModule() {
    dismissModule(animated: true, completion: nil)
  }
  
  func dismissModule(animated: Bool, completion: (() -> Void)?) {
    rootController.dismiss(animated: animated, completion: completion)
  }
  
  func push(_ module: Presentable)  {
    push(module, animated: true)
  }
  
  func push(_ module: Presentable, hideBottomBar: Bool)  {
    push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
  }
  
  func push(_ module: Presentable, animated: Bool)  {
    push(module, animated: animated, completion: nil)
  }
  
  func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
    push(module, animated: animated, hideBottomBar: false, completion: completion)
  }
  
  func push(_ module: Presentable, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
    guard
      (module is UINavigationController == false)
    else {
      assertionFailure("Deprecated push UINavigationController.")
      return
    }
    
    let controller = module.toPresent()
    if let completion = completion {
      completions[controller] = completion
    }
    controller.hidesBottomBarWhenPushed = hideBottomBar
    rootController.pushViewController(controller, animated: animated)
  }
  
  func popModule()  {
    popModule(animated: true)
  }
  
  func popModule(animated: Bool)  {
    if let controller = rootController.popViewController(animated: animated) {
      runCompletion(for: controller)
    }
  }
  
  func popToRootModule(animated: Bool) {
    if let controllers = rootController.popToRootViewController(animated: animated) {
      controllers.forEach { controller in
        runCompletion(for: controller)
      }
    }
  }
  
  private func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
}

extension RouterImp: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard
      let prevController = rootController.transitionCoordinator?.viewController(forKey: .from),
      rootController.viewControllers.contains(prevController) == false
    else { return }
    runCompletion(for: prevController)
  }
}

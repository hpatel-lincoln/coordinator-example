// Created by Hardik Patel on 9/4/21.

import UIKit

class TabBarController: UITabBarController {
  
  var didSelectIndex: ((Int) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
}

extension TabBarController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    didSelectIndex?(selectedIndex)
  }
}

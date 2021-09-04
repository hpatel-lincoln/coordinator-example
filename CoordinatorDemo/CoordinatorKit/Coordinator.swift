// Created by Hardik Patel on 9/4/21.

import Foundation

protocol Coordinator: AnyObject {
  func start()
  func start(with link: DeepLink?)
}

extension Coordinator {
  func start() {
    start(with: nil)
  }
}

protocol NavigationCoordinator: Coordinator {
  var hasStarted: Bool { get }
  var coordinator: Coordinator? { get }
  var router: Router { get }
}

protocol TabBarCoordinator: Coordinator {
  var coordinators: [Int: Coordinator] { get }
}

// Created by Hardik Patel on 9/4/21.

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController
}

extension UIViewController: Presentable {
  func toPresent() -> UIViewController {
    return self
  }
}

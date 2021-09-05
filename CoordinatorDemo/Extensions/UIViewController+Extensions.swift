// Created by Hardik Patel on 9/4/21.

import UIKit

extension UIViewController {
  
  static func instantiate<T>(from storyboard: Storyboard) -> T {
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
    let identifier = "\(T.self)"
    let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
    return controller
  }
}

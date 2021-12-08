// Created by Hardik Patel on 9/4/21.

import UIKit

class MoreViewController: UIViewController {
  
  var didTapAbout: (() -> Void)?
  var didTapLogout: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "More"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onAboutTap() {
    didTapAbout?()
  }
  
  @IBAction func onLogoutTap() {
    didTapLogout?()
  }
}

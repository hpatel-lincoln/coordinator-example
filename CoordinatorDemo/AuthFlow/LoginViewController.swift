// Created by Hardik Patel on 9/4/21.

import UIKit

class LoginViewController: UIViewController {
  
  var didCompleteLogin: (() -> Void)?
  var didTapSignup: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
  
  @IBAction func onLoginTap() {
    didCompleteLogin?()
  }
  
  @IBAction func onSignupTap() {
    didTapSignup?()
  }
}

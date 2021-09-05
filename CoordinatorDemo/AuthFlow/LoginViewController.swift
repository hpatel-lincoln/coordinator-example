// Created by Hardik Patel on 9/4/21.

import UIKit

class LoginViewController: UIViewController {
  
  var didCompleteLogin: (() -> Void)?
  var didTapSignup: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Login"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onLoginTap() {
    didCompleteLogin?()
  }
  
  @IBAction func onSignupTap() {
    didTapSignup?()
  }
}

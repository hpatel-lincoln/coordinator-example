// Created by Hardik Patel on 9/4/21.

import UIKit

class SignupViewController: UIViewController {
  
  var didCompleteSignup: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Signup"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onSignupTap() {
    didCompleteSignup?()
  }
}

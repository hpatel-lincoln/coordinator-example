// Created by Hardik Patel on 12/20/21.

import UIKit

class ProfileViewController: UIViewController {
  
  var didTapProfileDetail: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Profile"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onProfileDetailTap() {
    didTapProfileDetail?()
  }
}

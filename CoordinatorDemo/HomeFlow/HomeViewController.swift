// Created by Hardik Patel on 9/4/21.

import UIKit

class HomeViewController: UIViewController {
  
  var didTapProfileFlow: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Home"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onProfileFlowTap() {
    didTapProfileFlow?()
  }
}

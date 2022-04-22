// Created by Hardik Patel on 12/21/21.

import UIKit

class AgreementsViewController: UIViewController {
  
  var didTapNext: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Agreements"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onNextTap() {
    didTapNext?()
  }
}

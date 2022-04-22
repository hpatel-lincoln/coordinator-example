// Created by Hardik Patel on 12/22/21.

import UIKit

class AcceptAgreementsViewController: UIViewController {
  
  var didTapAccept: ((Bool) -> Void)?
  var didTapDecline: ((Bool) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Accept Agreements"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onAcceptTap() {
    didTapAccept?(true)
  }
  
  @IBAction func onDeclineTap() {
    didTapDecline?(false)
  }
}

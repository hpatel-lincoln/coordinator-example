// Created by Hardik Patel on 9/4/21.

import UIKit

class HomeViewController: UIViewController {
  
  var didTapViewProfile: (() -> Void)?
  var didTapShowAgreements: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Home"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func onViewProfileTap() {
    didTapViewProfile?()
  }
  
  @IBAction func onShowAgreementsTap() {
    didTapShowAgreements?()
  }
  
  func onAcceptAgreements(_ accepted: Bool) {
    let alertTitle = "Agreements"
    let alertMessage = accepted ? "You have accepted the agreements." : "You have declined the agreements."
    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    
    let okActionTitle = "Ok"
    let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: nil)
    alert.addAction(okAction)
    
    self.present(alert, animated: true, completion: nil)
  }
}

// Created by Hardik Patel on 12/21/21.

import UIKit

class AgreementsViewController: UIViewController {
  
  var didTapDone: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Agreements"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(onDoneTap))
  }
  
  @objc private func onDoneTap() {
    didTapDone?()
  }
}

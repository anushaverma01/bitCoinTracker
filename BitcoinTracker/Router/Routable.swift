//
//  Routable.swift
//  BitcoinTracker
//
//  Created by Anusha Verma on 13/07/21.
//

import Foundation
import UIKit

protocol ErrorRoutable: AnyObject {
    func showError(message: String)
}

protocol MessageShowRoutable: AnyObject {
    func showMessage(message: String)
}

protocol MessageRoutable: ErrorRoutable, MessageShowRoutable {}


extension UIViewController {
    
    func showAlert(title: String, message: String,actionButtonTitle: String = "Ok") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

       alert.addAction(UIAlertAction(title: actionButtonTitle, style: UIAlertAction.Style.default, handler: nil))

       self.present(alert, animated: true, completion: nil)
    
    }
}

//
//  UIViewController+Extension.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import UIKit

// MARK: - Error Alert
extension UIViewController {
    
    class func showErrorAlert(with navigation: UINavigationController?, message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString(message, comment: "You are offline"), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        if let navigation = navigation?.visibleViewController {
            if !(navigation.isKind(of: UIAlertController.self)) {
                OperationQueue.main.addOperation {
                    navigation.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

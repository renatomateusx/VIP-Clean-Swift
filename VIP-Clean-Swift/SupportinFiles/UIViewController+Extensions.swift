//
//  UIViewController+Extensions.swift
//  VIP-Clean-Swift
//
//  Created by Renato Mateus De Moura Santos on 12/10/21.
//

import UIKit

extension UIViewController {
    func showError(with message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

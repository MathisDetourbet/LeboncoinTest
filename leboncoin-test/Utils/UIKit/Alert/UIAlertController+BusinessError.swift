//
//  AlertController.swift
//  leboncoin-test
//
//  Created by Mathis Detourbet on 15/10/20.
//

import UIKit

extension UIAlertController {
    
    static func makeBusinessErrorAlert(_ businessError: BusinessError,
        title: String? = "Error",
        dismissAction: UIAlertAction
    ) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: businessError.errorDescription, preferredStyle: .alert)
        alert.addAction(dismissAction)
        return alert
    }
}

//
//  DismissKeyboard.swift
//  CGShop
//
//  Created by mac on 20/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func showOkAlert(title: String, message: String, callback: @escaping () -> ()?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                callback()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

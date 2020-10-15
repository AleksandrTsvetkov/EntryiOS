//
//  UIViewController.swift
//  VideoGorod
//
//  Created by Арсений Дорогин on 12.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func addDismissKeyboardByTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

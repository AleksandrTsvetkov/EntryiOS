//
//  UIViewController + Alert.swift
//  Party
//
//  Created by Александр Цветков on 29.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, text: String?) {
        let ac = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        ac.addAction(ok)
        present(ac, animated: true)
    }
}

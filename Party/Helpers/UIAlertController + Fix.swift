//
//  UIAlertController + Fix.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 22.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

extension UIAlertController {
    func removeNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}

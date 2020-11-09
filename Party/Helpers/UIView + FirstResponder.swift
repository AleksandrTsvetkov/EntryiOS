//
//  UIView + FirstResponder.swift
//  Party
//
//  Created by Александр Цветков on 07.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

extension UIView {
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }

        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }

        return nil
    }
}

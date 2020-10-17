//
//  Colors.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

enum Colors {
    
    case buttonGray
    case gray
    case pink
    case lightBlack
    case red
    case textFieldBackgroundResponder
    case textFieldBackgroundNotResponder
    case textFieldBorder
    
    func getValue() -> UIColor {
        switch self {
        case .buttonGray:
            return UIColor(hex: "757575")
        case .gray:
            return UIColor(hex: "EBEBF5", alpha: 0.6)
        case .pink:
            return UIColor(hex: "BF5AF2")
        case .lightBlack:
            return UIColor(hex: "202020", alpha: 0.92)
        case .red:
            return UIColor(hex: "FF453A")
        case .textFieldBackgroundResponder:
            return UIColor(hex: "2C2C2E")
        case .textFieldBackgroundNotResponder:
            return UIColor(hex: "1C1C1E")
        case .textFieldBorder:
            return UIColor(hex: "707070")
        }
    }
}

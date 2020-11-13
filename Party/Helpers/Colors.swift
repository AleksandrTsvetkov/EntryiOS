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
    case textFieldCorrect
    case tabBarBlack
    case backgroundBlack
    case backgroundGray
    case separator
    case selectedSegment
    case unselectedSegment
    case labelGray
    case cellBackground
    
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
        case .textFieldCorrect:
            return UIColor(hex: "32D74B")
        case .tabBarBlack:
            return UIColor(hex: "161616", alpha: 0.94)
        case .backgroundBlack:
            return UIColor(hex: "1D1D1D", alpha: 0.94)
        case .separator:
            return UIColor(hex: "38383A")
        case .backgroundGray:
            return UIColor(hex: "747480", alpha: 0.18)
        case .selectedSegment:
            return UIColor(hex: "636366")
        case .unselectedSegment:
            return UIColor(hex: "767680", alpha: 0.24)
        case .labelGray:
            return UIColor(hex: "99999F")
        case .cellBackground:
            return UIColor(hex: "2D2D2F")
        }
    }
}

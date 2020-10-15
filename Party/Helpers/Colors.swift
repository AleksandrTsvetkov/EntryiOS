//
//  Colors.swift
//  VideoGorod
//
//  Created by Арсений Дорогин on 08.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

enum Colors {
    
    case gray
    
    func getValue() -> UIColor {
        switch self {
        case .gray:
            return UIColor(hex: "EBEBF5", alpha: 0.6)
        }
    }
}

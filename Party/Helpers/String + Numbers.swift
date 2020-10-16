//
//  String + Numbers.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

extension String {
   var isNumeric: Bool {
     return self.allSatisfy { $0.isNumber }
   }
}

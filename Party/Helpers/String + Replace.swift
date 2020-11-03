//
//  String + Replace.swift
//  Party
//
//  Created by Александр Цветков on 02.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

extension String {
    func replace(_ with: String, at index: Int) -> String {
        var modifiedString = String()
        for (i, char) in self.enumerated() {
            modifiedString += String((i == index) ? with : String(char))
        }
        return modifiedString
    }
}

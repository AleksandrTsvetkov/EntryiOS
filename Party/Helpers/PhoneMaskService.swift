//
//  PhoneMaskService.swift
//  Party
//
//  Created by Александр Цветков on 02.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

class PhoneMaskService {
    var originalNumber: String = "" {
        didSet {
            if oldValue.first == "+" {
                originalNumber = String(oldValue.dropFirst())
            }
            convert()
        }
    }
    var visibleNumber: String = ""
    private let mask: String = "+_ (___) __-__-___"
    
    func convert() {
        var newVisibleNumber = mask
        for char in originalNumber {
            guard let index = newVisibleNumber.firstIndex(of: "_") else {
                visibleNumber = newVisibleNumber
                return
            }
            newVisibleNumber.remove(at: index)
            newVisibleNumber.insert(char, at: index)
        }
        visibleNumber = newVisibleNumber
    }
}

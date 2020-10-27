//
//  NetworkError.swift
//  Party
//
//  Created by Александр Цветков on 24.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case serverError(Error)
    case dataIsNil
    case responseIsNil
    case wrongStatusCode
}

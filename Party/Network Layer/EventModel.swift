//
//  EventModel.swift
//  Party
//
//  Created by Александр Цветков on 24.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

struct Event {
    var title: String
    var beginning: String
    var description: String
    var location_id: String
    var price: String?
    var ending: String?
    var shisha: String?
    var age_bottom_limit: String?
    var age_top_limit: String?
    var count_bottom_limit: String?
    var count_top_limit: String?
}

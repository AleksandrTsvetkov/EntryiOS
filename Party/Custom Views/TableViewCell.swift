//
//  TableViewCell.swift
//  Party
//
//  Created by Александр Цветков on 11.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol Reusable {}

extension Reusable where Self: UITableViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}

class TableViewCell: UITableViewCell {
    
    func configure() {
        selectionStyle = .none
        backgroundColor = .clear
    }

}

extension TableViewCell: Reusable {}

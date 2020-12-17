//
//  UITableView + Extension.swift
//  Party
//
//  Created by Александр Цветков on 11.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: TableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseId)
    }
    
    func dequeueReusableCell<T: TableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
}

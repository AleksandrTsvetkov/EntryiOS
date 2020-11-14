//
//  RatingView.swift
//  Party
//
//  Created by Александр Цветков on 14.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class RatingView: UIStackView {
    
    var eventRating: Double = 0.0
    private var stars: Array<UIImageView> = []
    
    convenience init(withRating rating: Double) {
        self.init(frame: .zero)
        initialSetup()
        setRating(rating)
    }
    
    private func initialSetup() {
        for _ in 0...4 {
            let image = UIImage(named: "emptyStar")
            let view = UIImageView(image: image)
            addArrangedSubview(view)
            stars.append(view)
        }
        spacing = 6
        axis = .horizontal
        distribution = .fillEqually
    }
    
    func setRating(_ rating: Double) {
        eventRating = rating
        deleteStars()
        let lastFullStar = Int(rating) >= 5 ? 5 : Int(rating)
        let remainder = rating - Double(lastFullStar)
        guard lastFullStar > 0 else {
            if remainder >= 0.5 {
                stars[0].image = UIImage(named: "halfStar")
                return
            } else {
                return
            }
        }
        for i in 1...lastFullStar {
            stars[i - 1].image = UIImage(named: "filledStar")
        }
        if lastFullStar < 5 && remainder >= 0.5 {
            stars[lastFullStar].image = UIImage(named: "halfStar")
        }
    }
    
    private func deleteStars() {
        for star in stars {
            star.image = UIImage(named: "emptyStar")
        }
    }
    
}

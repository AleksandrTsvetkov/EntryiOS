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
    var delegate: RatingDelegate?
    
    //MARK: - Init
    convenience init(withRating rating: Double) {
        self.init(frame: .zero)
        initialSetup()
        setRating(rating)
    }
    
    //MARK: - Setup
    private func initialSetup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(starTapped))
        self.addGestureRecognizer(tap)
        for _ in 0...4 {
            let image = UIImage(named: "emptyStar")
            let view = UIImageView()
            view.isUserInteractionEnabled = true
            view.image = image
            view.contentMode = .scaleAspectFit
            addArrangedSubview(view)
            stars.append(view)
        }
        spacing = 6
        axis = .horizontal
        distribution = .fillEqually
    }
    
    //MARK: - External methods
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
    
    //MARK: - Supporting methods
    private func deleteStars() {
        for star in stars {
            star.image = UIImage(named: "emptyStar")
        }
    }
    
    //MARK: - Objc methods
    @objc private func starTapped(_ sender: UITapGestureRecognizer) {
        switch sender.location(in: self).x {
        case 0...9:
            setRating(0.5)
        case 9...21:
            setRating(1.0)
        case 21...33:
            setRating(1.5)
        case 33...45:
            setRating(2.0)
        case 45...57:
            setRating(2.5)
        case 57...69:
            setRating(3.0)
        case 69...81:
            setRating(3.5)
        case 81...93:
            setRating(4.0)
        case 93...105:
            setRating(4.5)
        case 105...114:
            setRating(5.0)
        default:
            break
        }
    }
    
}

protocol RatingDelegate {
    func ratingChanged(newRating: Double)
}

//
//  PhotosCell.swift
//  Party
//
//  Created by Александр Цветков on 03.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    static let reuseId = "OverviewCell"
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eventImage")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Configure
    func configure() {
        backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

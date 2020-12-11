//
//  FeatureView.swift
//  Party
//
//  Created by Александр Цветков on 15.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class FeatureView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "SFProText-Semibold", size: 15)
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    private let subtitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "SFProText-Regular", size: 14)
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, subtitle: String, image: UIImage?) {
        self.init(frame: .zero)
        
        backgroundColor = .white
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupSubviews() {
        backgroundColor = .clear
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -2),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16)
        ])
    }
}

//
//  DistanceCell.swift
//  Party
//
//  Created by Александр Цветков on 27.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class DistanceCell: TableViewCell {
    
    //MARK: - Subviews
    private let distanceIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "distanceIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let distanceLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.text = "Дистанция"
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let radiusLabel: UILabel = {
        let view = UILabel()
        view.text = "В радиусе 2 км"
        view.textAlignment = .left
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Regular", size: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var radiusSlider: UISlider = {
        let view = UISlider()
        view.thumbTintColor = .white
        view.minimumValue = 0
        view.maximumValue = 110
        view.value = 12
        view.minimumTrackTintColor = Colors.pink.getValue()
        view.maximumTrackTintColor = Colors.sliderGray.getValue()
        view.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let radiusLeftLabel: UILabel = {
        let view = UILabel()
        view.text = "В этом доме"
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let radiusRightLabel: UILabel = {
        let view = UILabel()
        view.text = "< 100 км"
        view.textAlignment = .right
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Configure
    override func configure() {
        super.configure()
        setupSubviews()
    }
    
    //MARK: - Setup
    private func setupSubviews() {
        addSubview(distanceIcon)
        addSubview(distanceLabel)
        addSubview(radiusLabel)
        addSubview(radiusSlider)
        addSubview(radiusLeftLabel)
        addSubview(radiusRightLabel)
        
        NSLayoutConstraint.activate([
            distanceIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            distanceIcon.heightAnchor.constraint(equalToConstant: 20),
            distanceIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            distanceIcon.widthAnchor.constraint(equalToConstant: 20),
            
            distanceLabel.topAnchor.constraint(equalTo: distanceIcon.topAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: 20),
            distanceLabel.leadingAnchor.constraint(equalTo: distanceIcon.trailingAnchor, constant: 4),
            distanceLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            radiusLabel.topAnchor.constraint(equalTo: distanceIcon.bottomAnchor, constant: 24),
            radiusLabel.heightAnchor.constraint(equalToConstant: 26),
            radiusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            radiusLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            radiusSlider.topAnchor.constraint(equalTo: radiusLabel.bottomAnchor, constant: 16),
            radiusSlider.heightAnchor.constraint(equalToConstant: 28),
            radiusSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            radiusSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            radiusLeftLabel.topAnchor.constraint(equalTo: radiusSlider.bottomAnchor, constant: 7),
            radiusLeftLabel.heightAnchor.constraint(equalToConstant: 14),
            radiusLeftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            radiusLeftLabel.trailingAnchor.constraint(lessThanOrEqualTo: radiusRightLabel.leadingAnchor, constant: -20),
            
            radiusRightLabel.topAnchor.constraint(equalTo: radiusLeftLabel.topAnchor),
            radiusRightLabel.heightAnchor.constraint(equalToConstant: 14),
            radiusRightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    //MARK: - Objc methods
    @objc private func sliderValueChanged() {
        switch radiusSlider.value {
        case 0:
            radiusLabel.text = "В этом доме"
        case 1...10:
            radiusLabel.text = "В радиусе \(Int(radiusSlider.value))00 м"
        case 11...110:
            radiusLabel.text = "В радиусе \(Int(radiusSlider.value - 10)) км"
        default:
            break
        }
    }
    
}

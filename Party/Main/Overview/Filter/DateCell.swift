//
//  DateCell.swift
//  Party
//
//  Created by Александр Цветков on 27.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    
    static let reuseId = "DateCell"
    
    //MARK: - Subviews
    private let dateIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "dateIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateIconLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.text = "По дате"
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "В течение недели"
        view.textAlignment = .left
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Regular", size: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dateSlider: UISlider = {
        let view = UISlider()
        view.thumbTintColor = .white
        view.value = 6
        view.minimumValue = 0
        view.maximumValue = 11
        view.minimumTrackTintColor = Colors.pink.getValue()
        view.maximumTrackTintColor = Colors.sliderGray.getValue()
        view.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateLeftLabel: UILabel = {
        let view = UILabel()
        view.text = "Сегодня"
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateRightLabel: UILabel = {
        let view = UILabel()
        view.text = "В течение 3 месяцев"
        view.textAlignment = .right
        view.textColor = Colors.gray.getValue()
        view.font = UIFont(name: "SFProText-Regular", size: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Configure
    func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupSubviews()
    }
    
    //MARK: - Setup
    private func setupSubviews() {
        addSubview(dateIcon)
        addSubview(dateIconLabel)
        addSubview(dateLabel)
        addSubview(dateSlider)
        addSubview(dateLeftLabel)
        addSubview(dateRightLabel)
        
        NSLayoutConstraint.activate([
            dateIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            dateIcon.heightAnchor.constraint(equalToConstant: 20),
            dateIcon.widthAnchor.constraint(equalToConstant: 21),
            dateIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            dateIconLabel.centerYAnchor.constraint(equalTo: dateIcon.centerYAnchor),
            dateIconLabel.heightAnchor.constraint(equalToConstant: 20),
            dateIconLabel.leadingAnchor.constraint(equalTo: dateIcon.trailingAnchor, constant: 4),
            dateIconLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: dateIcon.bottomAnchor, constant: 24),
            dateLabel.heightAnchor.constraint(equalToConstant: 26),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            dateSlider.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            dateSlider.heightAnchor.constraint(equalToConstant: 28),
            dateSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            dateLeftLabel.topAnchor.constraint(equalTo: dateSlider.bottomAnchor, constant: 7),
            dateLeftLabel.heightAnchor.constraint(equalToConstant: 14),
            dateLeftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateLeftLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateRightLabel.leadingAnchor, constant: -20),
            
            dateRightLabel.topAnchor.constraint(equalTo: dateLeftLabel.topAnchor),
            dateRightLabel.heightAnchor.constraint(equalToConstant: 14),
            dateRightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    //MARK: - Objc methods
    @objc private func sliderValueChanged() {
        print(dateSlider.value)
        switch Int(dateSlider.value) {
        case 0:
            dateLabel.text = "Сегодня"
        case 1:
            dateLabel.text = "Сегодня и завтра"
        case 2...5:
            dateLabel.text = "В течение \(Int(dateSlider.value) + 1) дней"
        case 6:
            dateLabel.text = "В течение недели"
        case 7:
            dateLabel.text = "В течение двух недель"
        case 8:
            dateLabel.text = "В течение трёх недель"
        case 9:
            dateLabel.text = "В течение месяца"
        case 10:
            dateLabel.text = "В течение двух месяцев"
        case 11:
            dateLabel.text = "В течение трёх месяцев"
        default:
            break
        }
    }
}

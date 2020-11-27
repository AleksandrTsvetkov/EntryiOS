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
    private let dateIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "dateIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.text = "По дате"
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupViews()
    }

    private func setupViews() {
        addSubview(dateIcon)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            dateIcon.heightAnchor.constraint(equalToConstant: 20),
            dateIcon.widthAnchor.constraint(equalToConstant: 21),
            dateIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            dateLabel.centerYAnchor.constraint(equalTo: dateIcon.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: dateIcon.trailingAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
        ])
    }
}

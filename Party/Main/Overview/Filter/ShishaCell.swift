//
//  ShishaCell.swift
//  Party
//
//  Created by Александр Цветков on 27.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ShishaCell: UITableViewCell {

    static let reuseId = "ShishaCell"
    
    //MARK: - Subviews
    private let shishaIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "shishaIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let shishaLabel: UILabel = {
        let view = UILabel()
        view.text = "Кальян"
        view.textAlignment = .left
        view.textColor = .white
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var shishaSegmentedControl: SegmentedControl = SegmentedControl(withDelegate: selectionReceiverDelegate)
    
    //MARK: - Properties
    private var selectionReceiverDelegate: SelectionReceiverDelegate?
    
    //MARK: - Configure
    func configure(withDelegate delegate: SelectionReceiverDelegate) {
        backgroundColor = .clear
        selectionStyle = .none
        selectionReceiverDelegate = delegate
        
        setupSubviews()
    }

    //MARK: - Setup
    private func setupSubviews() {
        addSubview(shishaIcon)
        addSubview(shishaLabel)
        addSubview(shishaSegmentedControl)
        shishaSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shishaIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 68),
            shishaIcon.heightAnchor.constraint(equalToConstant: 20),
            shishaIcon.widthAnchor.constraint(equalToConstant: 19),
            shishaIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            shishaIcon.trailingAnchor.constraint(equalTo: shishaLabel.leadingAnchor, constant: -8),

            shishaLabel.centerYAnchor.constraint(equalTo: shishaIcon.centerYAnchor),
            shishaLabel.heightAnchor.constraint(equalToConstant: 20),
            shishaLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),

            shishaSegmentedControl.topAnchor.constraint(equalTo: shishaIcon.bottomAnchor, constant: 24),
            shishaSegmentedControl.heightAnchor.constraint(equalToConstant: 25),
            shishaSegmentedControl.widthAnchor.constraint(equalToConstant: 146),
            shishaSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])
    }
}

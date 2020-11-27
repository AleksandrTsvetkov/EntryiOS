//
//  SegmentedControl.swift
//  Party
//
//  Created by Александр Цветков on 25.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class SegmentedControl: UIView {
    
    private var selectionReceiverDelegate: SelectionReceiverDelegate?
    
    private let yesLabel: UILabel = {
        let view = UILabel()
        view.text = "Да"
        view.textColor = Colors.gray.getValue()
        view.textAlignment = .center
        view.font = UIFont(name: "SFProText-Regular", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let yesView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.layer.borderColor = Colors.gray.getValue().withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let noLabel: UILabel = {
        let view = UILabel()
        view.text = "Нет"
        view.textColor = Colors.gray.getValue()
        view.textAlignment = .center
        view.font = UIFont(name: "SFProText-Regular", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let noView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.layer.borderColor = Colors.gray.getValue().withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init(withDelegate delegate: SelectionReceiverDelegate?) {
        self.init(frame: .zero)
        selectionReceiverDelegate = delegate
        let tap0 = UITapGestureRecognizer(target: self, action: #selector(yesTapped))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(noTapped))
        yesView.addGestureRecognizer(tap0)
        noView.addGestureRecognizer(tap1)
        setupViews()
    }

    private func setupViews() {
        addSubview(yesView)
        addSubview(noView)
        yesView.addSubview(yesLabel)
        noView.addSubview(noLabel)
        
        NSLayoutConstraint.activate([
            yesView.topAnchor.constraint(equalTo: self.topAnchor),
            yesView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            yesView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            yesView.trailingAnchor.constraint(equalTo: noView.leadingAnchor, constant: -8),
            
            noView.topAnchor.constraint(equalTo: self.topAnchor),
            noView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            noView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            yesView.widthAnchor.constraint(equalToConstant: 69),
            noView.widthAnchor.constraint(equalToConstant: 69),
            
            yesLabel.centerYAnchor.constraint(equalTo: yesView.centerYAnchor),
            yesLabel.centerXAnchor.constraint(equalTo: yesView.centerXAnchor),
            yesLabel.heightAnchor.constraint(equalToConstant: 16),

            noLabel.centerYAnchor.constraint(equalTo: noView.centerYAnchor),
            noLabel.centerXAnchor.constraint(equalTo: noView.centerXAnchor),
            noLabel.heightAnchor.constraint(equalToConstant: 16),
        ])
        
    }
    
    @objc private func yesTapped() {
        selectionReceiverDelegate?.segmentSelected(.left)
    }
    
    @objc private func noTapped() {
        selectionReceiverDelegate?.segmentSelected(.right)
    }
    
    func selectYes() {
        yesView.backgroundColor = Colors.gray.getValue().withAlphaComponent(0.1)
        noView.backgroundColor = .clear
    }
    
    func selectNo() {
        yesView.backgroundColor = .clear
        noView.backgroundColor = Colors.gray.getValue().withAlphaComponent(0.1)
    }
}

protocol SelectionReceiverDelegate {
    func segmentSelected(_ segmentPosition: SegmentPosition)
}

enum SegmentPosition {
    case left
    case right
}

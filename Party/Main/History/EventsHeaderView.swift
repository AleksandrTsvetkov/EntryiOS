//
//  EventsHeaderView.swift
//  Party
//
//  Created by Александр Цветков on 12.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class EventsHeaderView: UIView {

    private let iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var iconWidth: CGFloat = 15.5
    
    convenience init(ofType type: EventHeaderType) {
        self.init(frame: .zero)
        initialSetup()
        
        switch type {
        case .underConsideration:
            label.text = "На рассмотрении"
            iconView.image = UIImage(named: "underConsiderationIcon")
            iconWidth = 15.5
        case .coming:
            label.text = "Предстоящие вечеринки"
            iconView.image = UIImage(named: "comingIcon")
            iconWidth = 20
        case .liked:
            label.text = "Понравившиеся вечеринки"
            iconView.image = UIImage(named: "likedIcon")
            iconWidth = 20.5
        case .history:
            label.text = "История"
            iconView.image = UIImage(named: "historyIcon")
            iconWidth = 18
        }
    }
    
    private func initialSetup() {
        addSubview(label)
        addSubview(iconView)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 0),
            label.heightAnchor.constraint(equalToConstant: 20),
            
            iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            iconView.widthAnchor.constraint(equalToConstant: iconWidth),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            iconView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
        ])
    }
    
    enum EventHeaderType {
        case underConsideration
        case coming
        case liked
        case history
    }
    
}

//
//  ReviewCell.swift
//  Party
//
//  Created by Александр Цветков on 03.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ReviewCell: TableViewCell {

    private let textView: UITextView = {
        let view = UITextView()
        view.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 18, right: 15)
        view.text = "Вечеринка прошла очень хорошо. Классная музыка, вкусные коктейли. Но впечатление очень сильно подпортило длительное ожидание в очереди - стояли больше получаса(("
        view.textAlignment = .left
        view.isEditable = false
        view.textContainer.lineBreakMode = .byWordWrapping
        view.textColor = UIColor.white.withAlphaComponent(0.65)
        view.font = UIFont(name: "SFProText-Regular", size: 15)
        view.isScrollEnabled = false
        view.keyboardAppearance = .dark
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.textFieldBackgroundResponder.getValue()
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
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }

}

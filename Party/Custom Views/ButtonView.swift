//
//  ButtonView.swift
//  Party
//
//  Created by Александр Цветков on 15.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    
    enum ButtonState {
        case next
        case error
    }
    var state: ButtonState = .next {
        willSet {
            switch newValue {
            case .next:
                self.setTitle(title: "Дальше")
            case .error:
                self.setTitle(title: "Попробовать еще раз")
            }
        }
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProText-Semibold", size: 17)
        view.textAlignment = .left
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "arrow")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(color: UIColor, title: String, left: CGFloat, right: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        self.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        setupViews(color: color, left: left, right: right)
    }
    
    func setColor(color: UIColor) {
        backgroundView.backgroundColor = color
    }
    
    func setTitle(title: String) {
        label.text = title
    }
    
    func checkTitle(_ title: String) -> Bool {
        return label.text == title
    }
    
    private func setupViews(color: UIColor, left: CGFloat, right: CGFloat) {
        backgroundColor = .clear
        addSubview(backgroundView)
        addSubview(label)
        addSubview(imageView)
        backgroundView.backgroundColor = color
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: left),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -right),
            backgroundView.heightAnchor.constraint(equalToConstant: 50),
            
            label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            
            imageView.heightAnchor.constraint(equalToConstant: 18),
            imageView.widthAnchor.constraint(equalToConstant: 18),
            imageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -17)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

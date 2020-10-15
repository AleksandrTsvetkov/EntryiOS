//
//  ButtonView.swift
//  Party
//
//  Created by Александр Цветков on 15.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    convenience init(backgroundColor: UIColor, title: String, left: CGFloat, right: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        self.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backgroundView)
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

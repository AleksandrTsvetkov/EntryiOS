//
//  FilterViewController.swift
//  Party
//
//  Created by Александр Цветков on 17.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let closeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "exit"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Фильтры"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textAlignment = .left
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
    private let radiusSlider: UISlider = {
        let view = UISlider()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let shishaIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "shishaIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let djIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "djIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "dateIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupViews()
    }
    
    private func initialSetup() {
        
    }

    private func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

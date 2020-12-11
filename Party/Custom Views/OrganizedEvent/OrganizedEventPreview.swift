//
//  OrganizedEventPreview.swift
//  Party
//
//  Created by Александр Цветков on 02.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class OrganizedEventPreview: UIView {

    //MARK: - Subviews
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let partyImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eventImage")
        view.layer.cornerRadius = 74.5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "LV_party"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let ratingView: RatingView = {
        let view = RatingView(withRating: 2.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let ratingCountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        view.textAlignment = .center
        view.textColor = Colors.gray.getValue()
        view.text = "3.5"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let watchFullInfoButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(nil, for: .normal)
        view.setTitle("Смотреть >", for: .normal)
        view.setTitleColor(Colors.pink.getValue(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.separatorStyle = .none
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Properties
    private var delegate: OrganizedEventPresenter?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withDelegate presenterDelegate: OrganizedEventPresenter) {
        self.init(frame: .zero)
        delegate = presenterDelegate
        initialSetup()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
        setupSubviews()
    }
    
    //MARK: - Setup
    private func initialSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.reuseId)
        watchFullInfoButton.addTarget(self, action: #selector(watchFullInfoButtonTapped), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        addSubview(backView)
        backView.addSubview(partyImageView)
        backView.addSubview(titleLabel)
        backView.addSubview(ratingView)
        backView.addSubview(ratingCountLabel)
        backView.addSubview(watchFullInfoButton)
        backView.addSubview(tableView)
        
        let spacing = (UIScreen.main.bounds.width - 247) / 2
        
        NSLayoutConstraint.activate([
            backView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.72),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            partyImageView.centerYAnchor.constraint(equalTo: backView.topAnchor),
            partyImageView.heightAnchor.constraint(equalToConstant: 155),
            partyImageView.widthAnchor.constraint(equalToConstant: 155),
            partyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: partyImageView.bottomAnchor, constant: 50),
            titleLabel.bottomAnchor.constraint(equalTo: ratingView.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            ratingView.heightAnchor.constraint(equalToConstant: 34),
            ratingView.widthAnchor.constraint(equalToConstant: 190),
            ratingView.trailingAnchor.constraint(equalTo: ratingCountLabel.leadingAnchor, constant: -13),
            ratingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            
            ratingCountLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingCountLabel.heightAnchor.constraint(equalToConstant: 34),
            ratingCountLabel.widthAnchor.constraint(equalToConstant: 44),
            ratingCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
            
            watchFullInfoButton.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 13),
            watchFullInfoButton.heightAnchor.constraint(equalToConstant: 20),
            watchFullInfoButton.widthAnchor.constraint(equalToConstant: 98),
            watchFullInfoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: watchFullInfoButton.bottomAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    //MARK: - Objc methods
    @objc private func watchFullInfoButtonTapped() {
        delegate?.presentOrganizedEventVC()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension OrganizedEventPreview: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 149
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseId, for: indexPath) as? ReviewCell else { return UITableViewCell() }
        cell.configure()
        return cell
    }
    
    
}

protocol OrganizedEventPresenter {
    func presentOrganizedEventVC()
}

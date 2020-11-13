//
//  HistoryCell.swift
//  Party
//
//  Created by Александр Цветков on 09.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    static let reuseId = "HistoryCell"
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.cellBackground.getValue()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var timeIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "timeIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let eventImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.image = UIImage(named: "eventImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configure() {
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backView)
        addSubview(dateLabel)
        addSubview(timeIcon)
        addSubview(timeLabel)
        addSubview(titleLabel)
        addSubview(eventImageView)
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func configureForPastEvent() {
        addSubview(ratingLabel)
        addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            
        ])
    }

    private func configureForFutureEvent() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

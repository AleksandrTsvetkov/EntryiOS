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
        view.font = UIFont(name: "SFProText-Medium", size: 14)
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
        view.font = UIFont(name: "SFProText-Medium", size: 12)
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProDisplay-Bold", size: 20)
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
        view.font = UIFont(name: "SFProText-Medium", size: 12)
        view.lineBreakMode = .byTruncatingTail
        view.textAlignment = .left
        view.textColor = Colors.gray.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "SFProText-Medium", size: 12)
        view.text = "Оцените"
        view.textColor = Colors.gray.getValue()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let ratingNumberLabel: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.font = UIFont(name: "SFProText-Medium", size: 16)
        view.textColor = Colors.gray.getValue()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var ratingView: RatingView = {
        let view = RatingView(withRating: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dateFormatter = DateFormatter()
    
    func configure(withModel event: Event, forType type: EventType) {
        selectionStyle = .none
        backgroundColor = .clear
        
        titleLabel.text = event.title
        var timeString = ""
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        if let date = dateFormatter.date(from: event.beginning) {
            //dateFormatter.dateStyle = .none
            //dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = "HH:mm"
            timeString = dateFormatter.string(from: date)
            //dateFormatter.dateStyle = .short
            //dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "d MMMM"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            timeString = "time"
            dateLabel.text = "date"
        }
        setupViews()
        if type == .history { configureForPastEvent(withModel: event) } else { configureForFutureEvent(time: timeString, description: event.description) }
    }
    
    private func setupViews() {
        addSubview(backView)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(eventImageView)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: backView.topAnchor, constant: -11),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dateLabel.heightAnchor.constraint(equalToConstant: 16),
            
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            eventImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8.5),
            eventImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8.5),
            eventImageView.widthAnchor.constraint(equalToConstant: 90),
            eventImageView.heightAnchor.constraint(equalToConstant: 90),
            eventImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -7),
            
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 11),
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 27),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventImageView.leadingAnchor, constant: -20),
        ])
    }
    
    private func configureForPastEvent(withModel event: Event) {
        addSubview(ratingLabel)
        addSubview(ratingView)
        addSubview(ratingNumberLabel)
        
        ratingNumberLabel.text = "\(ratingView.eventRating)"
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: -14),
            
            ratingLabel.bottomAnchor.constraint(equalTo: ratingView.topAnchor, constant: -7),
            ratingLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            ratingLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventImageView.leadingAnchor, constant: -20),
            ratingLabel.heightAnchor.constraint(equalToConstant: 14),
            
            ratingView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -17.5),
            ratingView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            ratingView.trailingAnchor.constraint(lessThanOrEqualTo: eventImageView.leadingAnchor, constant: -20),
            ratingView.heightAnchor.constraint(equalToConstant: 16.5),
            ratingView.widthAnchor.constraint(equalToConstant: 109.5),
            
            ratingNumberLabel.heightAnchor.constraint(equalToConstant: 19),
            ratingNumberLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingNumberLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 10),
            ratingNumberLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventImageView.leadingAnchor, constant: -20),
        ])
    }

    private func configureForFutureEvent(time: String, description: String) {
        addSubview(timeIcon)
        addSubview(timeLabel)
        addSubview(descriptionLabel)
        
        timeLabel.text = time
        descriptionLabel.text = description
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: timeIcon.topAnchor, constant: -13),
            
            timeIcon.heightAnchor.constraint(equalToConstant: 14),
            timeIcon.widthAnchor.constraint(equalToConstant: 14),
            timeIcon.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8),
            timeIcon.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12.5),
            timeIcon.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -6.5),
            
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventImageView.leadingAnchor, constant: -20),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 24),
            descriptionLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: eventImageView.leadingAnchor, constant: -20),
        ])
    }
}

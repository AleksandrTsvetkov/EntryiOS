//
//  FilterViewController.swift
//  Party
//
//  Created by Александр Цветков on 17.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let closeButton: UIButton = {
        let view = UIButton(type: .custom)
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
    private let applyButtonView: ButtonView = {
        let view = ButtonView(color: Colors.pink.getValue(), title: "Применить", left: 16, right: 16)
        view.changeIcon(newImageName: "checkMarkIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupViews()
        setupConstraints()
    }
    
    private func initialSetup() {
        let backColor = Colors.overViewCellBack.getValue().withAlphaComponent(0.94)
        view.backgroundColor = backColor
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DistanceCell.self, forCellReuseIdentifier: DistanceCell.reuseId)
        tableView.register(ShishaCell.self, forCellReuseIdentifier: ShishaCell.reuseId)
        tableView.register(DJCell.self, forCellReuseIdentifier: DJCell.reuseId)
        tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.reuseId)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(applyButtonView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 2),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            tableView.bottomAnchor.constraint(equalTo: applyButtonView.topAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            applyButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            applyButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            applyButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            applyButtonView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DistanceCell.reuseId, for: indexPath) as? DistanceCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShishaCell.reuseId, for: indexPath) as? ShishaCell else { return UITableViewCell() }
            cell.configure(withDelegate: self)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DJCell.reuseId, for: indexPath) as? DJCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.reuseId, for: indexPath) as? DateCell else { return UITableViewCell() }
            cell.configure()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 140
        case 1:
            return 137
        case 2:
            return 153.5
        case 3:
            return 70
        default:
            return 0
        }
    }
}

//MARK: - SelectionReceiverDelegate
extension FilterViewController: SelectionReceiverDelegate {
    
    func segmentSelected(_ segmentPosition: SegmentPosition) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShishaCell.reuseId, for: IndexPath(row: 1, section: 0)) as? ShishaCell else { return }
        switch segmentPosition {
        case .left:
            cell.shishaSegmentedControl.selectYes()
        case .right:
            cell.shishaSegmentedControl.selectNo()
        }
    }
}

//
//  OrganizedEventViewController.swift
//  Party
//
//  Created by Александр Цветков on 02.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class OrganizedEventViewController: ViewController {
    
    //MARK: - Subviews
    private let closeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "exit"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Drug"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textAlignment = .left
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.isScrollEnabled = true
        view.bounces = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupSubviews()
    }
    
    //MARK: - Setup
    private func initialSetup() {
        view.backgroundColor = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotosEventCell.self)
        tableView.register(InfoEventCell.self)
        tableView.register(WhereEventCell.self)
        tableView.register(DescriptionEventCell.self)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: - Objc methods
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension OrganizedEventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 264
        case 1:
            return 86
        case 2:
            return 52
        case 3:
            return 186
        case 4:
            return 86
        case 5:
            return 160
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: PhotosEventCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure()
            return cell
        case 1:
            let cell: InfoEventCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(forType: .time)
            return cell
        case 2:
            let cell: InfoEventCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(forType: .price)
            return cell
        case 3:
            let cell: WhereEventCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure()
            return cell
        case 4:
            let cell: InfoEventCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(forType: .dj)
            return cell
        case 5:
            let cell: DescriptionEventCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure()
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//
//  RegistrationViewController.swift
//  Party
//
//  Created by Александр Цветков on 17.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Регистрация"
        view.textColor = .white
        return view
    }()
    private lazy var buttonView = ButtonView(color: Colors.buttonGray.getValue(), title: "Дальше", left: 16, right: 16)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "phoneBackButton"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        tableView.keyboardDismissMode = .onDrag
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RegistrationCell.self, forCellReuseIdentifier: RegistrationCell.reuseId)
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(buttonView)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 376)
        ])
        if UIScreen.main.bounds.height < 600 {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60),
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            ])
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationCell.reuseId, for: indexPath) as! RegistrationCell
        cell.configure(withType: FieldType.allCases[indexPath.row])
        return cell
    }
    
    
}

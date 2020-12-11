//
//  MapViewController.swift
//  Party
//
//  Created by Александр Цветков on 31.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class MapViewController: ViewController {

    //MARK: - Subviews
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Colors.lightBlack.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var declineView = DeclineView()
    private lazy var searchBarView = SearchBarView(ofType: .withFilter, withDelegate: self)
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    //MARK: - Setup
    private func initialSetup() {
        view.backgroundColor = Colors.backgroundBlack.getValue()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: OverviewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseId)
        addMapPlaceholder()
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(searchBarView)
        view.addSubview(tableView)
        view.addSubview(declineView)
        
        NSLayoutConstraint.activate([
            declineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            declineView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            declineView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            declineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            declineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.heightAnchor.constraint(equalToConstant: 249),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBarView.heightAnchor.constraint(equalToConstant: 40),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func addMapPlaceholder() {
        let mapPlaceholderView = UIImageView(image: UIImage(named: "mapBigPlaceholder"))
        mapPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapPlaceholderView)
        NSLayoutConstraint.activate([
            mapPlaceholderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapPlaceholderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: - Supporting methods
    private func switchStateToResults() {
        tableView.isHidden = false
        collectionView.isHidden = true
        searchBarView.switchState(to: .withResults)
    }
    
    private func switchStateToFilter() {
        tableView.isHidden = true
        collectionView.isHidden = false
        searchBarView.switchState(to: .withFilter)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCell.reuseId, for: indexPath) as? OverviewCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 240, height: 212)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseId, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.configure()
        return cell
    }
}

//MARK: - SearchBarViewDelegate
extension MapViewController: SearchBarViewDelegate {
    
    func textFieldChanged(textField: UITextField) {
        guard let text = textField.text else {
            switchStateToFilter()
            return
        }
        if text != "" {
            switchStateToResults()
        } else {
            switchStateToFilter()
        }
    }
    
    func buttonTapped(ofType type: SearchBarType) {
        switch type {
        case .withFilter:
            let vc = FilterViewController()
            present(vc, animated: true)
        case .withResults:
            switchStateToFilter()
            searchBarView.clearSearch()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

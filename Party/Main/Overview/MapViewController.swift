//
//  MapViewController.swift
//  Party
//
//  Created by Александр Цветков on 31.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class MapViewController: ViewController {

    //MARK: - Properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Colors.lightBlack.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var searchBarView = SearchBarView(ofType: .withFilter, delegate: self)
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    private func initialSetup() {
        view.backgroundColor = Colors.backgroundBlack.getValue()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: OverviewCell.reuseId)
        
        setupViews()
    }

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(searchBarView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 249),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBarView.heightAnchor.constraint(equalToConstant: 40),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

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

extension MapViewController: SearchBarViewDelegate {
    
    func textFieldChanged(text: String) {
        
    }
    
    func buttonTapped(ofType type: SearchBarType) {
        
    }
}

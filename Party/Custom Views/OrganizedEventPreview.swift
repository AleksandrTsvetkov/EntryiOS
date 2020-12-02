//
//  OrganizedEventPreview.swift
//  Party
//
//  Created by Александр Цветков on 02.12.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class OrganizedEventPreview: UIView {

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        setupSubviews()
    }
    
    private func initialSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    private func setupSubviews() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension OrganizedEventPreview: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

//
//  HistoryViewController.swift
//  Party
//
//  Created by Александр Цветков on 31.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class HistoryViewController: ViewController {

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Мои вечеринки"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let counterLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "12"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 40)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let countLabel: UILabel = {
        let view = UILabel()
        view.textColor = Colors.labelGray.getValue()
        view.text = "В этом месяце"
        view.font = UIFont(name: "SFProText-Semibold", size: 15)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            view.layer.borderWidth = 0
        } else {
            view.layer.borderWidth = 1
        }
        view.layer.borderColor = Colors.unselectedSegment.getValue().cgColor
        view.layer.masksToBounds = true
        view.tintColor = Colors.selectedSegment.getValue()
        let normalFont = UIFont(name: "SFProText-Semibold", size: 13) ?? UIFont.systemFont(ofSize: 13)
        let selectedFont = UIFont(name: "SFProText-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: normalFont], for: .normal)
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: selectedFont], for: .selected)
        view.backgroundColor = Colors.unselectedSegment.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func setupViews() {
        view.backgroundColor = Colors.backgroundBlack.getValue()
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
        
        view.addSubview(tableView)
    }
    
}

//
//  RegistrationViewController.swift
//  Party
//
//  Created by Александр Цветков on 17.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "phoneBackButton"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

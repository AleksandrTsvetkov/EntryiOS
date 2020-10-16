//
//  RegistrationViewController.swift
//  Party
//
//  Created by Александр Цветков on 16.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var delegate: OnboardingViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "whyBackButton"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc private func backButtonTapped() {
        delegate.blurEffectView.isHidden = true
        delegate.authView.isHidden = true
        delegate.authView.transform = .identity
        delegate.authViewIsVisibleConstraint.isActive = false
        delegate.authViewIsHiddenConstraint.isActive = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }

}
